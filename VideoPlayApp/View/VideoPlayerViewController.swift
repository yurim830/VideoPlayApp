//
//  VideoPlayerViewController.swift
//  VideoPlayApp
//
//  Created by 김유림 on 11/14/25.
//

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {

    // MARK: - Properties

    private var skipUnit: Double = 10

    private var skipUITimer: Timer?
    private var tapCount: Int = 0
    private var accumulatedSkip: Double = 0

    private var isFirstTap = true
    private var isControlHidden: Bool = false


    // MARK: - UI Properties

    private let player: AVPlayer
    private var playerLayer: AVPlayerLayer
    private let controlView = VideoControlView()


    // MARK: - init

    init(player: AVPlayer) {
        self.player = player
        self.playerLayer = AVPlayerLayer(player: player)

        super.init(nibName: nil, bundle: nil)
    }

    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setStyle()
        setGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        player.play()
    }

}


// MARK: - UI Settings

private extension VideoPlayerViewController {

    func setHierarchy() {
        view.layer.addSublayer(playerLayer)
        [controlView].forEach { view.addSubview($0) }
    }

    func setLayout() {
        controlView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        playerLayer.frame = view.bounds
    }

    func setStyle() {
        controlView.hideButtons(isControlHidden)
    }

    func setGesture() {
        // 탭 제스처
        let leftDoubleTap = UITapGestureRecognizer(target: self, action: #selector(didTapLeft))
        let rightDoubleTap = UITapGestureRecognizer(target: self, action: #selector(didTapRight))
        controlView.leftView.addGestureRecognizer(leftDoubleTap)
        controlView.rightView.addGestureRecognizer(rightDoubleTap)
        
        // 설정 버튼
        controlView.settingsButton.addTarget(self, action:#selector(openSettings), for: .touchUpInside)
        
        // 재생/멈춤 버튼
        controlView.playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
    }
}


// MARK: - @objc functions

private extension VideoPlayerViewController {

    @objc func didTapLeft() {
        handleTap(isLeft: true)
    }

    @objc func didTapRight() {
        handleTap(isLeft: false)
    }

    @objc func openSettings() {
        let alert = UIAlertController(title: "건너뛰기 시간 설정",
                                      message: "몇 초씩 이동할까요?",
                                      preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "예: 5"
            textField.keyboardType = .numberPad
            textField.text = "\(Int(self.skipUnit))"
        }

        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            if let text = alert.textFields?.first?.text,
               let value = Double(text) {
                self.skipUnit = value
            }
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(ok)
        alert.addAction(cancel)

        present(alert, animated: true)
    }

    @objc func togglePlayPause() {
        if player.timeControlStatus == .playing {
            player.pause()
            controlView.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player.play()
            controlView.playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }

        animatePlayPauseButton()
    }
}


// MARK: - Helper

private extension VideoPlayerViewController {

    func animatePlayPauseButton() {
        UIView.animate(withDuration: 0.15, animations: {
            self.controlView.playPauseButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.15) {
                self.controlView.playPauseButton.transform = .identity
            }
        })
    }

    func seek(by seconds: Double) {
        let current = player.currentTime()
        let newTime = CMTimeGetSeconds(current) + seconds
        let time = CMTime(seconds: newTime, preferredTimescale: 1)

        player.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
    }

    func handleTap(isLeft: Bool) {
        // 즉각적으로 skip UI 업데이트
        let delta = isLeft ? -skipUnit : +skipUnit
        tapCount += isLeft ? -1 : +1

        if isFirstTap {
            // 첫 탭은 싱글 후보 → UI 업데이트 X
            isFirstTap = false
        } else {
            // 두 번째 탭부터는 즉각 UI 업데이트
            accumulatedSkip += delta
            updateSkipUI(accumulatedSkip)
        }

        // 타이머 리셋
        skipUITimer?.invalidate()
        skipUITimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
            self?.processTapResult()
        }
    }

    func processTapResult() {
        if abs(tapCount) == 1 {
            toggleControlVisibility()
        } else {
            let skipUnits = abs(tapCount) - 1
            let direction: Double = tapCount > 0 ? 1 : -1
            let finalSkip = Double(skipUnits) * skipUnit * direction

            seek(by: finalSkip)
        }

        // Reset
        tapCount = 0
        isFirstTap = true
        accumulatedSkip = 0
    }

    func updateSkipUI(_ value: Double) {
        controlView.setSkipLabel(value)
    }

    func toggleControlVisibility() {
        isControlHidden.toggle()
        UIView.animate(withDuration: 0.2) {
            self.controlView.hideButtons(self.isControlHidden)
        }
    }

}
