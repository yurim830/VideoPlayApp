//
//  TableViewCell.swift
//  VideoPlayApp
//
//  Created by 유림 on 5/6/24.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static let identifier = String(describing: TableViewCell.self)
    
    var stackView: UIStackView {
        let stackView = UIStackView()
        contentView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .red
        return stackView
    }
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

    func setConstraints() {
        // stackView
        stackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        // stackView addArrangedSubview
        [thumbnailImageView, titleLabel].forEach {
            stackView.addArrangedSubview($0) // stackView는 addArrangedSubview로 뷰 추가해야 함
        }
    }
    
}
