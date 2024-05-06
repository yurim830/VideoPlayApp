//
//  ViewController.swift
//  VideoPlayApp
//
//  Created by 유림 on 5/6/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConstraints()
    }
    
    func setTableViewConstraints() {
        view.addSubview(tableView) // addSubView는 constraints 설정 전에 해줘야 함!
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

