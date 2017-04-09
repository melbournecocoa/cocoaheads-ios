//
//  EventViewModel.swift
//  CocoaHeadsMobile
//
//  Created by Jesse Collis on 9/4/17.
//  Copyright © 2017 Melbourne CocoaHeads. All rights reserved.
//

import UIKit
import Foundation
import APIClient

struct ListEvent {
    let title:String
    let subtitle:String
    let url:URL
  
    init(title:String, subtitle:String, url:URL) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
    }
    
    init?(fromEvent event:Event) {
        guard let title = event.title, let subtitle = event.subtitle, let urlString = event.url else {
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        self.init(title: title, subtitle: subtitle, url:url)
    }
}
