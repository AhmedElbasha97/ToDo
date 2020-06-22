//
//  File.swift
//  ToDo
//
//  Created by ahmedelbasha on 5/17/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//
import UIKit
import Foundation
extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
