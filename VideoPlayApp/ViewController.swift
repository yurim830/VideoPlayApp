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
    var videoDetails: [VideoDetails]?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideoDetails()
        setTableViewConstraints()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setTableViewConstraints() {
        view.addSubview(tableView) // addSubView는 constraints 설정 전에 해줘야 함!
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.rowHeight = CGFloat(100)
    }
    
    func fetchVideoDetails() {
        Task {
            do {
                let videoData = try await APIManager.shared.fetchUrlData(url: APIManager.shared.url)
                let videoDetail = APIManager.shared.decodeIntoVideoDetails(videoData)
                self.videoDetails = videoDetail
            } catch {
                print("error: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configureCell()
        return cell
    }
    
    
}
