//
//  ViewController.swift
//  YoutubeVideo
//
//  Created by Mahmut Senbek on 24.01.2023.
//

import UIKit
import YoutubePlayer_in_WKWebView
import AVKit

class ViewController: UIViewController, WKYTPlayerViewDelegate {
    var youtubeId = ""
    
    @IBOutlet weak var player: WKYTPlayerView!
    var youtubeUrl = "https://www.youtube.com/watch?v=WnSSvz9ry_w&ab_channel=Webkul"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.youtubeId = youtubeUrl.youtubeID ?? ""
         print("YoutubeId is: \(self.youtubeId)")
     loadvideo()
            self.player.delegate = self
       
    }
    
    func loadvideo() {
        DispatchQueue.main.async {
            self.player.load(withVideoId: self.youtubeId, playerVars: ["playsinline":"0"])
        }
       
    }
    
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        DispatchQueue.main.async {
            self.player.playVideo()
        }
    
     }
     override func viewDidDisappear(_ animated: Bool) {
     player.stopVideo()
     
     }


}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
}

