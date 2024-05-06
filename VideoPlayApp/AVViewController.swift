//
//  AVViewController.swift
//  VideoPlayApp
//
//  Created by 유림 on 5/7/24.
//

import UIKit
import AVKit

class AVViewController: AVPlayerViewController {
    
    static let shared = AVViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func presentAVPlayer(_ videoURL: URL) {
        
    }
}
