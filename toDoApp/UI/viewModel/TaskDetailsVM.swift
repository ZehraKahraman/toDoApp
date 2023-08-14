//
//  TaskDetailsVM.swift
//  toDoApp
//
//  Created by zehra on 12.08.2023.
//

import Foundation

class TaskDetailsVM {
    var trepo = TasksDaoRepo()
    
    func update(task_id: Int, task_name: String, task_description: String, deadline: String){
        trepo.update(task_id: task_id, task_name: task_name, task_description: task_description, deadline: deadline)
    }
}
