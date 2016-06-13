//
//  VideoVC.swift
//  The Coding Challenge
//
//  Created by admin on 22/04/16.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//
import UIKit
import WebKit

class VideoVC: UIViewController {
    //Embeding youtub video tutorial in the App.
    
    @IBOutlet var videoView:UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let YoutubeLink = "https://www.youtube.com/embed/uDp_jmkPbiQ"
        
        let width = 300
        let height = 250
        let frame = 100
        let Code = "<html><body><iframe width=\"\(width)\" height=\"\(height)\" src=\"\(YoutubeLink)\" frameborder=\"\(frame)\" allowfullscreen></iframe></body></html>"
        self.videoView.loadHTMLString(Code, baseURL: nil)
    }
    
}
