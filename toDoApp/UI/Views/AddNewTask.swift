//
//  AddNewTask.swift
//  toDoApp
//
//  Created by zehra on 2.08.2023.
//

import UIKit

class AddNewTask: UIViewController {

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var deadlineField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    var datePicker: UIDatePicker?
    var viewModel = AddNewTaskVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDescription.layer.cornerRadius = 8
        taskDescription.layer.masksToBounds = true
        taskDescription.layer.borderWidth = 0.3
        taskDescription.layer.borderColor = UIColor.lightGray.cgColor
        saveButtonOutlet.layer.cornerRadius = 8

        

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.preferredDatePickerStyle = .wheels
        deadlineField.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(self.showDate(datePicker:)), for: .valueChanged)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.gestureRecognizer))
        
        view.addGestureRecognizer(gesture)

    }
    
    @objc func showDate(datePicker:UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let finalDate = dateFormatter.string(from: datePicker.date)
        
        deadlineField.text = finalDate
    }
    
    @objc func gestureRecognizer(){
         view.endEditing(true)
        
    }

    
    @IBAction func saveButtonAct(_ sender: Any) {
        if let taskName = taskNameField.text, let taskDescription = taskDescription.text, let deadline = deadlineField.text {
            viewModel.save(task_name: taskName, task_description: taskDescription, deadline: deadline)
        }
    }
    
}
