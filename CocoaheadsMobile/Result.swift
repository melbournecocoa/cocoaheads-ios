//
//  Result.swift
//  CocoaHeadsMobile
//
//  Created by Jesse Collis on 13/4/17.
//  Copyright © 2017 Melbourne CocoaHeads. All rights reserved.
//

import Foundation

// Smaller implementation based off https://github.com/antitypical/Result/blob/master/Result/Result.swift

enum Result<T> {
  case success(T)
  case failure(Error)
  
  init(value: T) {
    self = .success(value)
  }
  
  init (error: Error) {
    self = .failure(error)
  }
  
  init (_ value: T?, failWith: @autoclosure () -> Error ) {
    self = value.map(Result.success) ?? .failure(failWith())
  }
}
