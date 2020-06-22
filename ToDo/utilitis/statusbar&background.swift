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
extension UIViewController{
    func setStatusBarColor(){
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.purple
    }
    func setUpTheBackGroundImage()  {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background 2")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}
