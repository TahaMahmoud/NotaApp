//
//  AddTaskVC.swift
//  NotaApp
//
//  Created by Taha on 12/2/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import UIKit

class AddTaskVC: UIViewController {

    @IBOutlet weak var noteTextTF: UITextField!
    
    internal var presenter: AddTaskPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddTaskPresenter(view: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTaskBTNPressed(_ sender: Any) {
        
        let taskText: String = noteTextTF.text!
        presenter?.addTask(taskText: taskText)
    }
    
    @IBAction func backBTNPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        Helper.showViewByIdentifer(storyboardID: "Main", viewControllerID: "tasksListVC")
    }
    
}

extension AddTaskVC: AddTaskDelegate
{
    func showMessage(title:String, message: String) {
        Helper.showAlert(title: title, message: message, actionTitle: "OK", viewController: self)
    }
    
    func taskAdded() {
        // clear note text
        noteTextTF.text = ""
    }
    
    
}
