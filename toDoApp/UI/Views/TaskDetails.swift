//
//  TaskDetails.swift
//  toDoApp
//
//  Created by zehra on 2.08.2023.
//

import UIKit

class TaskDetails: UIViewController {

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var taskNameArea: UITextField!
    @IBOutlet weak var taskDescriptionArea: UITextView!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var deadlineArea: UITextField!
    @IBOutlet weak var updateButtonOutlet: UIButton!
    
    var task:Tasks?
    var datePicker:UIDatePicker?
    var viewModel = TaskDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDescriptionArea.layer.cornerRadius = 8
        taskDescriptionArea.layer.masksToBounds = true
        taskDescriptionArea.layer.borderWidth = 0.3
        taskDescriptionArea.layer.borderColor = UIColor.lightGray.cgColor
        updateButtonOutlet.layer.cornerRadius = 8
        
        if let t = task{
            taskNameArea.text = t.task_name
            taskDescriptionArea.text = t.task_description
            deadlineArea.text = t.deadline
        }
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.preferredDatePickerStyle = .wheels
        deadlineArea.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(self.showDate(datePicker:)), for: .valueChanged)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.gestureRecognizer))
        
        view.addGestureRecognizer(gesture)

    }
    
    @objc func showDate(datePicker:UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let finalDate = dateFormatter.string(from: datePicker.date)
        
        deadlineArea.text = finalDate
    }
    
    @objc func gestureRecognizer(){
         view.endEditing(true)
        
    }


    @IBAction func updateButton(_ sender: Any) {
        if let taskName = taskNameArea.text,let taskDescription = taskDescriptionArea.text, let deadline = deadlineArea.text, let t = task{
            viewModel.update(task_id: t.task_id!, task_name: taskName, task_description: taskDescription , deadline: deadline)
        }
    }
}
