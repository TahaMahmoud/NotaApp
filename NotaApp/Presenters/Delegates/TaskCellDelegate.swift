//
//  TaskCellDelegate.swift
//  NotaApp
//
//  Created by Taha on 12/3/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
protocol TaskCellDelegate: class {
    func checkTaskPressed(taskID: Int, taskState: String)
    func removeTaskPressed(taskID: Int)
}
