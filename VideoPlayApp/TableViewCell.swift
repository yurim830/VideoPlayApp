//
//  TableViewCell.swift
//  VideoPlayApp
//
//  Created by 유림 on 5/6/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var stackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .red
        return stackView
    }
    var thumbnailImageView = UIImageView()
    var titleLabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setConstraints() {
        // stackView
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // stackView addArrangedSubview
        [thumbnailImageView, titleLabel].forEach {
            stackView.addArrangedSubview($0) // stackView는 addArrangedSubview로 뷰 추가해야 함
        }
    }
    
}
