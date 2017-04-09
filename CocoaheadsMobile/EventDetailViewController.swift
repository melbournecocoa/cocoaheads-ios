//
//  EventDetailViewController.swift
//  CocoaHeadsMobile
//
//  Created by Jesse Collis on 9/4/17.
//  Copyright © 2017 Melbourne CocoaHeads. All rights reserved.
//

import UIKit
import WebKit

class EventDetailViewController: UIViewController {

    var webView: WKWebView?
    
    var event:ListEvent? {
        didSet {
            if let event = event {
                self.title = event.title
                
                if isViewLoaded {
                    load(url:event.url)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView(frame: self.view.bounds)
        
        self.view.addSubview(webView)
        webView.activateSuperviewHuggingConstraints()
        
        self.webView = webView
        
        if let event = self.event {
            load(url: event.url)
        }
    }
    
    func load(url:URL) {
        let request = URLRequest(url: url);
        self.webView?.load(request)
    }
}
