//
//  Task.swift
//  NotaApp
//
//  Created by Taha on 12/2/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation

class Task {
    var taskID: Int
    var taskText: String = ""
    var taskState: String = ""
    
    init(taskID: Int, taskText: String, taskState: String) {
        self.taskID = taskID
        self.taskText = taskText
        self.taskState = taskState
    }

}

