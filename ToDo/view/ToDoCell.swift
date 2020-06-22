//
//  ToDoCell.swift
//  ToDo
//
//  Created by ahmedelbasha on 6/19/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
     var delegate: showAlertOfDeletingDelegate?
    var callback : ((UITableViewCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configurecell(todo: ToDo) {
        dateLabel.text = todo.DateAndTime
        contentLabel.text = todo.content
    }
    @IBAction func deleteBTN(_ sender: UIButton) {
        callback?(self)
        self.delegate?.showAlertOfDeleting(customTableViewCell: self, didTapButton: sender)
        
    }
}
protocol showAlertOfDeletingDelegate{
    func showAlertOfDeleting(customTableViewCell: UITableViewCell, didTapButton button: UIButton)
}

