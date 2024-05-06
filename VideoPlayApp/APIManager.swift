//
//  APIManager.swift
//  VideoPlayApp
//
//  Created by 유림 on 5/6/24.
//

import Foundation

class APIManager {
    let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json")!
    
    func fetchURLData(_ url: URL) -> Data {
        var urlData: Data?
        let session = URLSession(configuration: .default, delegate: .none, delegateQueue: nil)
        
        // URLSessionDataTask로 비동기적으로 데이터 요청
        let task = session.dataTask(with: url) { data, response, error in
            // 1. 성공한 응답 걸러내기
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)
            else {
                print("데이터 통신 실패: \(error)")
                return
            }
            
            // 2. 데이터 옵셔널 해제
            guard let data = data else { return }
            urlData = data
        }
        return urlData!
    }
    
    func decodeIntoVideoModel(_ data: Data) -> VideoModel? {
        let decoder = JSONDecoder()
        do {
            let video = try decoder.decode(VideoModel.self, from: data)
            return video
        } catch {
            print("decoding error: \(error)")
            return nil
        }
    }
    
}
