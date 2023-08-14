//
//  AddNewTaskVM.swift
//  toDoApp
//
//  Created by zehra on 12.08.2023.
//

import Foundation

class AddNewTaskVM {
    var trepo = TasksDaoRepo()
    
    func save(task_name:String,task_description:String, deadline: String) {
        trepo.save(task_name: task_name, task_description: task_description, deadline: deadline)
    }
    
}
