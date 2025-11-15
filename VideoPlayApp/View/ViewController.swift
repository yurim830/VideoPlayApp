//
//  ViewController.swift
//  VideoPlayApp
//
//  Created by 유림 on 5/6/24.
//

import UIKit
import AVKit
import SnapKit

class ViewController: UIViewController {

    var tableView = UITableView()
    var videoDetailsArr: [VideoDetails]? {
        didSet {
            tableView.reloadData()
        }
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
    }
    
    func fetchVideoDetails() {
        Task {
            do {
                let videoData = try await APIManager.shared.fetchUrlData(url: APIManager.shared.url)
                let videoDetail = APIManager.shared.decodeIntoVideoDetails(videoData)
                self.videoDetailsArr = videoDetail
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // 셀 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoDetailsArr?.count ?? 0
    }
    
    // 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell,
              let videoDetailsArr = self.videoDetailsArr
        else { return UITableViewCell() }
        
        let videoDetails = videoDetailsArr[indexPath.row]
        cell.configureCell(videoDetails)
        return cell
    }
    
    // 행 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // 셀 터치 시 비디오 재생
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let videoDetailsArr = self.videoDetailsArr else { return }
        let videoURL = videoDetailsArr[indexPath.row].videoUrl
        let vc = VideoPlayerViewController(videoURL)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}
