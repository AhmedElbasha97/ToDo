//
//  ToDoVC.swift
//  ToDo
//
//  Created by ahmedelbasha on 5/29/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
class ToDoVC: UIViewController {
    var ToDos: [ToDo] = []
    @IBOutlet weak var ToDoListView: UITableView!
     var ref: DatabaseReference!
    var addNewTask: Bool = UserDefaults.standard.bool(forKey: UserDeafultsKey.addNewTask)
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference()
    
        if(addNewTask){
         getDataOfToDo()
        UserDefaults.standard.set(false, forKey: UserDeafultsKey.addNewTask)
        }
       
       setUpToDoTable()
        SetUpNavBar()
        getDataOfToDo()
        // Do any additional
    }
    override func viewWillAppear(_ animated: Bool) {
      
        if(addNewTask){
            getDataOfToDo()
            UserDefaults.standard.set(false, forKey: UserDeafultsKey.addNewTask)
        }
    }
    private func SetUpNavBar() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .purple
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
          guard let currentUserID = Auth.auth().currentUser?.uid else { return }
       self.ref.child(tablesInDataBase.users).child(currentUserID).child(tablesInDataBase.userAccount).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let userName = value?[FieldsInUserTable.userName] as? String
            self.navigationItem.title = userName
        }) { (error) in
            print(error.localizedDescription)
        }
    }
     func getDataOfToDo(){
        guard let key = Auth.auth().currentUser?.uid else { return }
        let itemsRef = self.ref.child(tablesInDataBase.users).child(key).child(tablesInDataBase.ToDo)
        itemsRef.observeSingleEvent(of: .value, with: { snapshot in
            var todoArr: [ToDo] = []
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: Any]
                let taskKey = snap.key
                let taskContent = dict[FieldsInToDoTable.ToDoContent] as! String
                let DateAndTimeOfTheTask = dict[FieldsInToDoTable.ToDoDateAndTime] as! String
                let todo = ToDo(taskId: taskKey, DateAndTime: DateAndTimeOfTheTask, content: taskContent)
                todoArr.append(todo)
            }
            self.ToDos = todoArr
            self.ToDoListView.reloadData()
            print(self.ToDos as Any)
        })

    }
    private func setUpToDoTable(){
        self.ToDoListView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.ToDoListView.backgroundView = UIImageView(image: UIImage(named: "background 2"))
        ToDoListView.register(UINib(nibName: Cells.ToDoCell, bundle: nil), forCellReuseIdentifier: Cells.ToDoCell)
        ToDoListView.dataSource = self
        ToDoListView.delegate = self
        self.ToDoListView.reloadData()
        
    }

}
extension ToDoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ToDoListView.dequeueReusableCell(withIdentifier: Cells.ToDoCell , for: indexPath) as? ToDoCell else {
            return UITableViewCell()
        }
        cell.configurecell(todo: ToDos[indexPath.row])
        let viewSeparatorLine = UIView(frame:CGRect(x: 0, y: cell.contentView.frame.size.height - 1, width: cell.contentView.frame.size.width, height: 2))
        viewSeparatorLine.backgroundColor = UIColor(red: 142/255, green: 69/255, blue: 196/255, alpha: 1)
        cell.contentView.addSubview(viewSeparatorLine)
        cell.backgroundColor = .clear
        cell.isOpaque = false
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.ToDoListView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension ToDoVC: showAlertOfDeletingDelegate {
    
    func showAlertOfDeleting(customTableViewCell: UITableViewCell, didTapButton button: UIButton) {
        guard let indexPath = self.ToDoListView.indexPath(for: customTableViewCell) else {return}
        let alert = UIAlertController(title: "Sorry", message: "Are You Sure Want to Delete this TODO?", preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            
            guard let userId = Auth.auth().currentUser?.uid else { return}
            guard let ToDoId = self.ToDos[indexPath.row].taskId else {return}
            self.ref.child(tablesInDataBase.users).child(userId).child(tablesInDataBase.ToDo).child(ToDoId).removeValue()
            self.getDataOfToDo()
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true, completion: nil)
    }
}
