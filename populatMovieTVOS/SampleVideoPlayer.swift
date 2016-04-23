//
//  SampleVideoPlayer.swift
//  populatMovieTVOS
//
//  Created by Miwand Najafe on 2015-11-09.
//  Copyright © 2015 Miwand Najafe. All rights reserved.
//

import UIKit
import AVKit
//import AVFoundation

class SampleVideoPlayer:AVPlayerViewController {
    var movieTrailer:String!
    
    func playVideo() {
        let myBaseUrl = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        guard let url = NSURL(string: myBaseUrl) else {
            print("movie trailer not found")
            return
        }
        player = AVPlayer(URL: url)
        player?.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: Play youtube clip needs testing with youtube app
    func playUtube(urlString:String) {
        let baseURL = "youtube://"
        let baseURL2 = "https://youtube/"
        if let url = NSURL(string: baseURL + urlString) {
            if  UIApplication.sharedApplication().canOpenURL(url) {
                UIApplication.sharedApplication().openURL(url)
            } else {
                if let url2 = NSURL(string: baseURL2 + urlString) {
                    UIApplication.sharedApplication().openURL(url2)
                }
            }
        }
    }
    
}
