//
//  DataModel.swift
//  VideoPlayApp
//
//  Created by 유림 on 5/6/24.
//

import Foundation

struct VideoModel: Decodable {
    let title: String
    let thumbnailUrl: URL
    let videoUrl: URL
}
