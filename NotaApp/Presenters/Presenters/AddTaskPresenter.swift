//
//  AddTaskPresenter.swift
//  NotaApp
//
//  Created by Taha on 12/2/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
class AddTaskPresenter {
    
    weak internal var delegate: AddTaskDelegate?
    fileprivate let dataManager: CoreDataManager
    
    init(view: AddTaskDelegate, dataManager: CoreDataManager = CoreDataManager()) {
        self.delegate = view
        self.dataManager = dataManager
    }

    func addTask(taskText: String) {
        
        if taskText == ""
        {
            delegate?.showMessage(title: "Error", message: "Note can't be Empty")
        }
        else
        {
            // create new task
            
            // get last task id from user defaults to increase in by one
            // to use as a primary key for taskID property
            let lastTaskID: Int = UserDefaultsManager.getTaskID()!
            
            let task: Task = Task(taskID: lastTaskID+1, taskText: taskText, taskState: "")
            
            dataManager.addTask(task: task)
            delegate?.showMessage(title: "Success", message: "Note added successfully")
            delegate?.taskAdded()
        }
        
    }

}
