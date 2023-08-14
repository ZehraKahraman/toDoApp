//
//  ViewController.swift
//  toDoApp
//
//  Created by zehra on 2.08.2023.
//

import UIKit

class MainPage: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var toDoTableView: UITableView!
    
    var toDoLists = [Tasks]()
    var viewModel = MainPageVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        _ = viewModel.tasksList.subscribe(onNext: { list in
            self.toDoLists = list
            self.toDoTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) { //when we turn back from detail or new task page, should be reload data to the main page
        viewModel.loadTasks()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let task = sender as? Tasks{
                let arrivedVC = segue.destination as! TaskDetails//downcasting
                arrivedVC.task = task
            }
        }
    }
    
}

extension MainPage: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchedWord: searchText)
    }
}

extension MainPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = toDoLists[indexPath.row] //0,1,2,3
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoCell
        cell.taskNameLabel.text = task.task_name
        cell.taskDescriptionLabel.text = task.task_description
        cell.dateLabel.text = task.deadline
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = toDoLists[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: task)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            contextualAction,view,bool in
            let task = self.toDoLists[indexPath.row]
            
            let alert = UIAlertController(title: "Deleting", message: "Are you sure to delete of \(task.task_name!) named task?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive){ action in
                self.viewModel.delete(task_id: task.task_id!)
            }
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
