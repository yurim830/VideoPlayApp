//
//  VideoControlView.swift
//  VideoPlayApp
//
//  Created by 김유림 on 11/14/25.
//

import UIKit

import Then
import SnapKit

class VideoControlView: UIView {

    // MARK: - UI Properties
    
    let leftView = UIView()
    let rightView = UIView()
    let leftSkipLabel = UILabel()
    let rightSkipLabel = UILabel()
    let settingsButton = UIButton(type: .system)
    let playPauseButton = UIButton(type: .system)
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    let xButton = UIButton()


    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - UI settings

private extension VideoControlView {
    
    func setHierarchy() {
        [leftView, rightView, settingsButton, xButton, playPauseButton, loadingIndicator].forEach { self.addSubview($0) }
        leftView.addSubview(leftSkipLabel)
        rightView.addSubview(rightSkipLabel)
    }

    func setLayout() {
        leftView.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
            $0.trailing.equalTo(self.snp.centerX)
        }

        rightView.snp.makeConstraints {
            $0.trailing.verticalEdges.equalToSuperview()
            $0.leading.equalTo(self.snp.centerX)
        }

        leftSkipLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        rightSkipLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        settingsButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.size.equalTo(60)
        }

        xButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).inset(10)
            $0.size.equalTo(60)
        }

        playPauseButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(60)
        }

        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(60)
        }
    }

    func setStyle() {
        leftView.do {
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .clear
        }

        rightView.do {
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .clear
        }

        [leftSkipLabel, rightSkipLabel].forEach {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.layer.opacity = 0
        }

        settingsButton.do {
            $0.tintColor = .white
            $0.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        }

        xButton.do {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
            $0.setPreferredSymbolConfiguration(config, forImageIn: .normal)
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .white
            
        }

        playPauseButton.do {
            $0.tintColor = .white
            $0.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }

}

// MARK: - Internal Methods

extension VideoControlView {

    func hideButtons(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.4) {
            [self.settingsButton, self.xButton, self.playPauseButton].forEach {
                $0.layer.opacity = isHidden ? 0.0 : 1.0
                $0.isHidden = isHidden
            }
            self.backgroundColor = .black.withAlphaComponent(isHidden ? 0.0 : 0.7)
        }
    }

    func setSkipLabel(_ time: Double) {
        let absTime: Double = abs(time)
        if time < 0 {
            leftSkipLabel.text = "- " + String(absTime)
            leftSkipLabel.layer.opacity = 1
        } else {
            rightSkipLabel.text = "+ " + String(absTime)
            rightSkipLabel.layer.opacity = 1
        }
        
        UIView.animate(withDuration: 1.0) {
            [self.leftSkipLabel, self.rightSkipLabel].forEach {
                $0.layer.opacity = 0.0
            }
        }
    }

    func setPlayPauseButtonImage(isPlaying: Bool) {
        let playPauseImg = UIImage(systemName: isPlaying ? "pause.fill" : "play.fill")
        playPauseButton.setImage(playPauseImg, for: .normal)
    }
}
