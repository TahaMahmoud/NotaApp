//
//  TasksListPresenter.swift
//  NotaApp
//
//  Created by Taha on 12/3/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
class TasksListPresenter {
    
    weak internal var delegate: TasksListDelegate?
    fileprivate let dataManager: CoreDataManager
    
    init(view: TasksListDelegate, dataManager: CoreDataManager = CoreDataManager()) {
        self.delegate = view
        self.dataManager = dataManager
    }

    func fetchTasks() {
    
        // get tasks from CoreDataManager and send it to the delegate
                
        dataManager.getTasks { [weak self] tasks, error in
                    
            // error
            guard error == "" else {
                self?.delegate?.showMessage(title: "Error", message: error)
                return
            }
                
            if tasks!.count == 0 {
                self?.delegate?.showMessage(title: "Empty", message: "Your notes list is currently empty, Start adding new notes")
                
                // reset ID 
                UserDefaultsManager.saveTaskID(taskID: 0)
            }
            else
            {
                // to map or not to map?
                // let mappedTasks = tasks.mapToViewData
                                
                self?.delegate?.setTasks(tasks!)
            }
                        
        }

    }
    
    func clearTasks() {
        
        if dataManager.getTasksCount() != 0
        {
            dataManager.clearTasks()
            // set taskID in userdefault to 0
            UserDefaultsManager.saveTaskID(taskID: 0)
        }
        
    }

}

