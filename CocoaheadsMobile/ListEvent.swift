//
//  EventViewModel.swift
//  CocoaHeadsMobile
//
//  Created by Jesse Collis on 9/4/17.
//  Copyright © 2017 Melbourne CocoaHeads. All rights reserved.
//

import UIKit
import Foundation
import CocoaHeadsAPIClient

struct ListEvent {
    let title: String
    let subtitle: String
    let url: URL
  
    init(title: String, subtitle: String, url: URL) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
    }
    
    init?(fromEvent event: Event) {
        guard let url = URL(string: event.links.web) else {
            return nil
        }
        
        self.init(title: event.title, subtitle: event._description, url:url)
    }
}
