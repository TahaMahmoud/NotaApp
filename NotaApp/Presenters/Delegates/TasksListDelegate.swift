//
//  TasksListDelegate.swift
//  NotaApp
//
//  Created by Taha on 12/3/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
protocol TasksListDelegate: class {
    
    func showMessage(title:String, message: String)
    func setTasks(_ tasks: [Task])
    func clearTasks()
}
