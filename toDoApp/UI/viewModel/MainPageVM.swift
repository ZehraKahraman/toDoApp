//
//  MainPageVM.swift
//  toDoApp
//
//  Created by zehra on 12.08.2023.
//

import Foundation
import RxSwift

class MainPageVM {
    var trepo = TasksDaoRepo()
    var tasksList = BehaviorSubject<[Tasks]>(value: [Tasks]())//trigger and listen
    
    init(){ // when created a object from Mainpage, init func run and connect the tasktlists
        tasksList = trepo.tasksList
        tasksList = trepo.tasksList
    }

    
    func delete(task_id:Int){
        trepo.delete(task_id: task_id)
        loadTasks()
    }
    
    func search(searchedWord:String){
        trepo.search(searchedWord: searchedWord)
    }
    
    func loadTasks(){
        trepo.loadTasks()
    }
    
    func copyDB(){
        let bundlePath = Bundle.main.path(forResource: "tasks", ofType: ".db")
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!//
        let dbURL = URL(fileURLWithPath: filePath).appendingPathComponent("tasks.db")
        
        let fm = FileManager.default
        
        if fm.fileExists(atPath: dbURL.path()){
            print("Database already exists!")
        }else{
            do{
                try fm.copyItem(atPath: bundlePath!, toPath: dbURL.path)
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
}
