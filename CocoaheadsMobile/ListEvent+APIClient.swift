//
//  ListEvent+APIClient.swift
//  CocoaHeadsMobile
//
//  Created by Jesse Collis on 9/4/17.
//  Copyright © 2017 Melbourne CocoaHeads. All rights reserved.
//

import Foundation
import UIKit
import APIClient

extension ListEvent {
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
