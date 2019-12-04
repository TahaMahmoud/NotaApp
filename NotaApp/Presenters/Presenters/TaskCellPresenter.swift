//
//  TaskCellPresenter.swift
//  NotaApp
//
//  Created by Taha on 12/3/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
class TaskCellPresenter {
    
    weak internal var delegate: TaskCellDelegate?
    fileprivate let dataManager: CoreDataManager
    
    init(view: TaskCellDelegate, dataManager: CoreDataManager = CoreDataManager()) {
        self.delegate = view
        self.dataManager = dataManager
    }

    func removeTask(taskID: Int) {
        dataManager.removeTask(taskID: taskID)
    }
    
    func checkTask(taskID:Int, taskState: String) {

        var state = ""
        
        if taskState == ""
        {
            state = "Done"
        }

        dataManager.checkTask(taskID: taskID, taskState: state)
    }

}

