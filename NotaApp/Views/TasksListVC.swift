//
//  TasksListVC.swift
//  NotaApp
//
//  Created by Taha on 12/2/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import UIKit

class TasksListVC: UIViewController {

    @IBOutlet weak var tasksTableView: UITableView!
    
    
    fileprivate var tasks = [Task]()
    internal var tasksPresenter: TasksListPresenter?
    internal var cellPresenter: TaskCellPresenter?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksPresenter = TasksListPresenter(view: self)
        tasksPresenter?.fetchTasks()
    
        cellPresenter = TaskCellPresenter(view: self)
        
    }
        
    @IBAction func clearPressed(_ sender: Any) {
        tasksPresenter?.clearTasks()
        reloadTableView()
    }

}
extension TasksListVC: TasksListDelegate {
    func clearTasks() {}
    
    func showMessage(title: String, message: String) {
        Helper.showAlert(title: title, message: message, actionTitle: "OK", viewController: self)
    }
    
    func setTasks(_ tasks: [Task]) {
        self.tasks = tasks
        self.tasksTableView.reloadData()
    }
    
}

extension TasksListVC: TaskCellDelegate {
    
    func checkTaskPressed(taskID: Int, taskState: String) {
        cellPresenter?.checkTask(taskID: taskID, taskState: taskState)
        reloadTableView()
    }
    
    func removeTaskPressed(taskID: Int) {
        cellPresenter?.removeTask(taskID: taskID)
        reloadTableView()
    }
    
    func reloadTableView() {
        tasks.removeAll()
        tasksTableView.reloadData()
        tasksPresenter?.fetchTasks()
    }
    
}

extension TasksListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[indexPath.row]
        let cell: TaskCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.noteText.text = task.taskText
                
        if task.taskState == "Done"
        {
            cell.checkBTN.setImage(UIImage(named:"TaskChecked" ), for: .normal)
        }
        else
        {
            cell.checkBTN.setImage(UIImage(named:"TaskNonChecked" ), for: .normal)
        }
        
        cell.task = task
        cell.delegate = self
        
        return cell

    }
    
}
extension TasksListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
