//
//  ToDoCell.swift
//  toDoApp
//
//  Created by zehra on 5.08.2023.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
