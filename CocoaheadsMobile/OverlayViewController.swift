//
//  OverlayViewController.swift
//  CocoaHeadsMobile
//
//  Created by Jesse Collis on 9/4/17.
//  Copyright © 2017 Melbourne CocoaHeads. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {

    var message:String? {
        didSet {
            if let message = message, isViewLoaded {
                self.messageLabel?.text = message
            }
        }
    }
    
    @IBOutlet var messageLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let message = message {
            self.messageLabel?.text = message
        }
    }
}
