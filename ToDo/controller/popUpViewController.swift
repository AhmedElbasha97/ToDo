//
//  popUpViewController.swift
//  ToDo
//
//  Created by ahmedelbasha on 6/3/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class popUpViewController: UIViewController {
    @IBOutlet weak var contentDataField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var popUpView: UIView!
    var ref: DatabaseReference!
    let dateOfTheTask = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference()
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "background 2")
//        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
//        self.popUpView.insertSubview(backgroundImage, at: 0)
    SetUpButtonDatePicking(textField: dateTextField)
        
    }
    func SetUpButtonDatePicking(textField: UITextField){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.chooseDateOfTheTask), for: .touchUpInside)
        
        textField.rightView = button
        textField.rightViewMode = .always
        
    }
    @IBAction func chooseDateOfTheTask(_ sender: Any) {
    
        let toolBar = UIToolbar()
       toolBar.sizeToFit()
        let doneBTN = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBTNPressed))
        let spaceBetweenTwoBTN = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelBTN = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelBTNPressed))
        toolBar.setItems([doneBTN,spaceBetweenTwoBTN,cancelBTN], animated: true)
       dateTextField.inputAccessoryView = toolBar
       dateTextField.inputView = dateOfTheTask
       dateOfTheTask.minimumDate = Date()
       dateOfTheTask.datePickerMode = .dateAndTime
        self.dateTextField.becomeFirstResponder()
        
    }
    @objc func doneBTNPressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
       
     dateTextField.text = dateFormatter.string(from: dateOfTheTask.date)
     self.view.endEditing(true)
    }
    @objc func cancelBTNPressed(){
        self.view.endEditing(true)
        
    }
    func uploadingTheTask(todoContent: String, todoDateAndTime: String ){
        guard let key = Auth.auth().currentUser?.uid else { return }
        let values = ["\(FieldsInToDoTable.ToDoContent)": todoContent, "\(FieldsInToDoTable.ToDoDateAndTime)": todoDateAndTime]
        ref.child("\(tablesInDataBase.users)").child(key).child("\(tablesInDataBase.ToDo)").childByAutoId().setValue(values)
    }
    
    
    func goTotoDoVCScreen(){
        let toDoVC = UIStoryboard.init(name: "\(Storyboards.todoTable)", bundle: nil).instantiateViewController(withIdentifier: "\(VCs.ToDoVC)") as! ToDoVC
        self.present(toDoVC, animated: true)
        
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if(fieldIsNotEmpty(field: dateTextField.text ?? "")){
            if(fieldIsNotEmpty(field: contentDataField.text ?? "")){
                uploadingTheTask(todoContent: contentDataField.text!, todoDateAndTime: dateTextField.text!)
                UserDefaults.standard.set(true, forKey: UserDeafultsKey.addNewTask)
              //goTotoDoVCScreen()
            }else{
                showAlert(title: "the task is not found", massage: "please input your task")
            }
        }else{
        showAlert(title: "date and the time of the task is not found", massage: "please input the date and the time of the task ")
        }
            }
}
