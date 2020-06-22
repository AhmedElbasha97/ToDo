//
//  Alerts.swift
//  ToDo
//
//  Created by ahmedelbasha on 5/17/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//

import Foundation
import Foundation
import UIKit
extension UIViewController{
    func showAlert(title: String, massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertController.Style.alert)
        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.purple]), forKey: "attributedTitle")
        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.lightGray]), forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
//extension ToDoCell{
//    func showdeleteMassage(idOfTheTask: String){
//   let alert = UIAlertController(title: "sorry", message: "Are You Sure You Want To Delete This TODO? ", preferredStyle: UIAlertController.Style.alert)
//
//     present(alert, animated: true, completion: nil)
//    }
//}
