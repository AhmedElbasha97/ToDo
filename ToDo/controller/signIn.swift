//
//  signIn.swift
//  ToDo
//
//  Created by ahmedelbasha on 5/20/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
class SignIn: UIViewController {
var dbRef: DatabaseReference!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarColor()
        setUpTheBackGroundImage()
        self.dbRef = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    func signUserInUsingFireBase (){
        Auth.auth().signIn(withEmail: (userEmail.text ?? ""), password: (userPassword.text ?? "")) { (result, error) in
            if let _eror = error{
                self.showAlert(title:"something wrong happen"
                    , massage: "\(_eror.localizedDescription)")
            }else{
            
            }
        }
    }
    func goTotoDoVCScreen(){
        let toDoVC = UIStoryboard.init(name: "\(Storyboards.todoTable)", bundle: nil).instantiateViewController(withIdentifier: "\(VCs.ToDoVC)") as! ToDoVC
        self.present(toDoVC, animated: true)
        
    }
    @IBAction func LogInBTN(_ sender: Any) {
        if (fieldIsNotEmpty(field: userEmail.text ?? "")&&fieldIsNotEmpty(field: userPassword.text ?? "")){
            if isValidEmail(candidate: userEmail.text ?? "" ){
                if validpassword(mypassword: userPassword.text ?? ""){
                    signUserInUsingFireBase()
                    //goTotoDoVCScreen()
                }else{
                    showAlert(title: "Your Password Doesn't meet the criteria of our app", massage: "Strong Password Criteria Must Contain The Following  Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character" )
                }
            }else{
                showAlert(title: "E-mail Is Not Valid", massage: "Please Put Avalid E-mail")
            }
        }else{
            showAlert(title: "text field is empty", massage: "please input your data")
        }
    }
    
}
