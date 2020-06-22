//
//  user.swift
//  ToDo
//
//  Created by ahmedelbasha on 5/20/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UserAccount{
    
    var userID: String
    var email: String
    var name: String
    
    init(userID: String, email: String, name: String){
        
        self.userID = userID
        self.email = email
        self.name = name
    }//end init
    
  
   
    
}
