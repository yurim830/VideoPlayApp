//
//  APIManager.swift
//  VideoPlayApp
//
//  Created by 유림 on 5/6/24.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json")!
    
//    func fetchURLData(_ url: URL) -> Data? {
//        var urlData: Data?
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        
//        // URLSessionDataTask로 비동기적으로 데이터 요청
//        let task = session.dataTask(with: url) { (data, response, error) in
//            // 1. 성공한 응답 걸러내기
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200..<300).contains(httpResponse.statusCode)
//            else {
//                print("데이터 통신 실패: \(error)")
//                return
//            }
//            
//            // 2. 데이터 리턴
//            print("데이터 통신 성공: \(data)")
//            urlData = data
//        }
//        task.resume()
//        return urlData
//    }
    
    func fetchUrlData(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        let httpResponse = response as! HTTPURLResponse
        if (200..<300).contains(httpResponse.statusCode) {
            print("statusCode: \(httpResponse.statusCode)")
        }
        print("data: \(data)")
        return data
    }
    
    func decodeIntoVideoDetails(_ data: Data) -> [VideoDetails]? {
        let decoder = JSONDecoder()
        do {
            let video = try decoder.decode([VideoDetails].self, from: data)
            return video
        } catch {
            print("decoding error: \(error)")
            return nil
        }
    }
    
}
