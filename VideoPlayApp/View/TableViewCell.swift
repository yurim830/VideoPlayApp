//
//  TableViewCell.swift
//  VideoPlayApp
//
//  Created by 유림 on 5/6/24.
//

import UIKit

import SnapKit
import Then

class TableViewCell: UITableViewCell {
    
    static let identifier = String(describing: TableViewCell.self)
    
    var stackView = UIStackView()
    var thumbnailImageView = UIImageView()
    var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func configureCell(_ videoDetails: VideoDetails) {
        self.selectionStyle = .none
        setSubviews()
        setStackView()
        setThumbnailImage(videoDetails)
        setTitleLabel(videoDetails)
    }
    
    func setSubviews() {
        // stackView
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        // stackView addArrangedSubview
        [thumbnailImageView, titleLabel].forEach {
            stackView.addArrangedSubview($0) // stackView는 addArrangedSubview로 뷰 추가해야 함
        }
    }
    
    func setStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
    }
    
    func setThumbnailImage(_ videoDetails: VideoDetails) {
        let imageURL = videoDetails.thumbnailUrl
        thumbnailImageView.do {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
        Task {
            do {
                let imageData = try await APIManager.shared.fetchUrlData(url: imageURL)
                thumbnailImageView.image = UIImage(data: imageData)
            } catch {
                print("imageData error: \(error)")
            }
        }
    }
    
    func setTitleLabel(_ videoDetails: VideoDetails) {
        let title = videoDetails.title
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        titleLabel.numberOfLines = 0
    }
}
