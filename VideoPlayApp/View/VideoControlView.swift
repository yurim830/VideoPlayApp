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
    let settingsButton = UIButton(type: .system)
    let playPauseButton = UIButton(type: .system)


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
        [leftView, rightView, settingsButton, playPauseButton].forEach { self.addSubview($0) }
    }

    func setLayout() {
        leftView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(ScreenUtils.width / 2)
        }

        rightView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(ScreenUtils.width / 2)
        }

        settingsButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(20)
            $0.size.equalTo(60)
        }

        playPauseButton.snp.makeConstraints {
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
        settingsButton.do {
            $0.tintColor = .white
            $0.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
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
        [settingsButton, playPauseButton].forEach {
            $0.isHidden = isHidden
            self.backgroundColor = .black.withAlphaComponent(isHidden ? 0.0 : 0.7)

        }
    }

}
