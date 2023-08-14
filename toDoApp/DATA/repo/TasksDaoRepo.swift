//
//  TasksDaoRepo.swift
//  toDoApp
//
//  Created by zehra on 12.08.2023.
//

import Foundation
import RxSwift

class TasksDaoRepo{
    var tasksList = BehaviorSubject<[Tasks]>(value: [Tasks]())//trigger and listen
    
    let db:FMDatabase?
    
    init(){
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!//
        let dbURL = URL(fileURLWithPath: filePath).appendingPathComponent("tasks.db")
        db = FMDatabase(path: dbURL.path)
    }
    
    
    func save(task_name:String,task_description:String, deadline: String) {
        
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO tasks (task_name,task_description,deadline) VALUES (?,?,?)", values: [task_name,task_description,deadline])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func update(task_id: Int, task_name: String, task_description: String, deadline: String){
        db?.open()
        do{
            try db!.executeUpdate("UPDATE tasks SET task_name = ?, task_description = ?, deadline = ? WHERE task_id = ?", values: [task_name,task_description,deadline,task_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()    }
    
    func delete(task_id:Int){
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM tasks WHERE task_id = ?", values: [task_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()    }
    
    func search(searchedWord:String){
        
        db?.open()
        var list = [Tasks]()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM tasks WHERE task_name like '%\(searchedWord)%'", values: nil)
            
            while result.next(){
                let task_id = Int(result.string(forColumn: "task_id"))!
                let task_name = result.string(forColumn: "task_name")!
                let task_description = result.string(forColumn: "task_description")!
                let deadline = result.string(forColumn: "deadline")!
                
                
                let task = Tasks(task_id: task_id, task_name: task_name, task_description: task_description, deadline: deadline)
                list.append(task)
            }
            tasksList.onNext(list)//tetikleme
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    
    func loadTasks(){
        db?.open()
        var list = [Tasks]()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM tasks", values: nil)
            
            while result.next(){
                let task_id = Int(result.string(forColumn: "task_id"))!
                let task_name = result.string(forColumn: "task_name")!
                let task_description = result.string(forColumn: "task_description")!
                let deadline = result.string(forColumn: "deadline")!
                
                let task = Tasks(task_id: task_id, task_name: task_name, task_description: task_description, deadline: deadline)
                list.append(task)
            }
            tasksList.onNext(list)//tetikleme
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
