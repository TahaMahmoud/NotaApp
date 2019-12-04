//
//  AddTaskDelegate.swift
//  NotaApp
//
//  Created by Taha on 12/2/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
protocol AddTaskDelegate: class {
    func showMessage(title:String, message: String)
    func taskAdded()
}
