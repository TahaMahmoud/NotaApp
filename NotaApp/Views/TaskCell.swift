//
//  TaskCell.swift
//  NotaApp
//
//  Created by Taha on 12/3/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    var task: Task?
    
    @IBOutlet weak var checkBTN: UIButton!
    @IBOutlet weak var noteText: UILabel!
    
    var delegate: TaskCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkTaskPressed(_ sender: Any) {
        
        delegate?.checkTaskPressed(taskID: task!.taskID, taskState: task!.taskState )
    }
    
    @IBAction func removeTaskPressed(_ sender: Any) {
        delegate?.removeTaskPressed(taskID: task!.taskID)
    }
    
}
