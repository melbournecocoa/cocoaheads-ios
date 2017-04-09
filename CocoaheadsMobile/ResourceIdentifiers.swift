//
//  ResourceIdentifiers.swift
//  CocoaHeadsMobile
//
//  Created by Jesse Collis on 9/4/17.
//  Copyright © 2017 Melbourne CocoaHeads. All rights reserved.
//

import UIKit

public extension UITableView {
    public enum CellIdentifier: String {
        case listCell
    }
    
    func dequeueReusableCell(withIdentifier cellIdentifier: UITableView.CellIdentifier, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: cellIdentifier.rawValue, for: indexPath)
    }
}
