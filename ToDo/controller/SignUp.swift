//
//  ViewController.swift
//  ToDo
//
//  Created by ahmedelbasha on 5/16/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//

import UIKit
import TextFieldEffects
import FirebaseAuth
import FirebaseDatabase
import Firebase
class SignUp: UIViewController {



    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    var dbRef: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
   setStatusBarColor()
   setUpTheBackGroundImage()
        self.dbRef = Database.database().reference()
        
    }
    func addUserToFireBase(){
     
        
   
        Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!, completion: {
            
            //This is where your uid is created. You can access it by using user!uid. Be sure to unwrap it.
            (user, error) in
            print("my userID is \(user!.user.uid)")
            
            if error != nil{
                self.showAlert(title: "Error has been happen", massage: "\(error!.localizedDescription)")
                print("Account Creation Error: \(error!.localizedDescription))")
                return
            }
            
            //This constant holds the uid. It comes from the (user, error). The user argument has a uid string property
            let currentUserID = user!.user.uid// which is the same as FIRAuth.auth()?.currentUser?.uid
            
            //Here you initialize an empty dictionary to hold the keys and values you want uploaded to your database
            var dict = [String:Any]()
            
            //use the dictionary’s updateValue() method to update the values and matching keys
            dict.updateValue(currentUserID, forKey: "\(FieldsInUserTable.userId)")
            dict.updateValue(self.userEmail.text!, forKey: "\(FieldsInUserTable.userEmail)")
            dict.updateValue(self.userName.text!, forKey: "\(FieldsInUserTable.userName)")
            
            //This gives you reference to your database, then to a child node named "users", then another node using the uid, and finally to another node named "userAccount". This final node is where you will keep your dictionary values for your database.
            let userAccountRef = self.dbRef.child("\(tablesInDataBase.users)").child(currentUserID).child("\(tablesInDataBase.userAccount)")
            
            //Here you upload your dictionary to the userAccountRef with the dictionary key/values you set above using the dict’s updateValue() method
            userAccountRef.setValue(dict)
        })
    }
    func goToSignInScreen(){
        let signInVC = UIStoryboard.init(name: "\(Storyboards.main)", bundle: nil).instantiateViewController(withIdentifier: "\(VCs.signInVC)") as! SignIn
        self.present(signInVC, animated: true)
        
    }
    @IBAction func signUp(_ sender: Any) {
        if (fieldIsNotEmpty(field: userEmail.text ?? "")&&fieldIsNotEmpty(field: userName.text ?? "")&&fieldIsNotEmpty(field: userPassword.text ?? "")){
            if isValidEmail(candidate: userEmail.text ?? "" ){
                if validpassword(mypassword: userPassword.text ?? ""){
                    addUserToFireBase()
                    goToSignInScreen()
                    
                }else{
                    showAlert(title: "Your Password Is Weak", massage: "Strong Password Criteria Must Contain The Following  Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character" )
                }
            }else{
               showAlert(title: "E-mail Is Not Valid", massage: "Please Put Avalid E-mail")
            }
        }else{
            showAlert(title: "text field is empty", massage: "please input your data")
        }
        
    }
    
    }
    

    


