//
//  constructor.swift
//  ToDo
//
//  Created by ahmedelbasha on 5/20/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//

import Foundation
struct Cells {
    static let ToDoCell = "ToDoCell"
}

// Storyboards
struct Storyboards {
    static let main = "Main"
    static let todoTable = "ToDoTable"
    
}

// ViewControllers
struct VCs {
    static let signUpVC = "SignUp"
    static let signInVC = "SignIn"
    static let ToDoVC = "ToDoVC"
 
}
struct UserDeafultsKey {
    static let addNewTask = "addNewTask"
}

struct tablesInDataBase {
    static let users = "users"
    static let userAccount = "userAccount"
    static let ToDo = "ToDos"
}
struct FieldsInUserTable {
    static let userName = "acctCreationDateKey"
    static let userId = "userIDKey"
    static let userEmail = "emailKey"
}
struct FieldsInToDoTable {
    
    static let ToDoContent = "todo"
    static let ToDoDateAndTime = "dateAndTime"
}

