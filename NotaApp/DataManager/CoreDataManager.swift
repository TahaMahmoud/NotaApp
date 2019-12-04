//
//  TaskDataManager.swift
//  NotaApp
//
//  Created by Taha on 12/2/19.
//  Copyright © 2019 Taha. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let managedContext = CoreDataManagerConfig.managedContext
    let tasksEntity = CoreDataManagerConfig.tasksEntity
    
    //Prepare the request of type NSFetchRequest  for the entity
    let fetchTasksRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
    
    func addTask(task: Task) {
        
        // Get task data
        
        let taskID: Int = task.taskID
        let taskText: String = task.taskText
        let taskState: String = task.taskState
        
        let task = NSManagedObject(entity: tasksEntity, insertInto: managedContext)
        task.setValue(taskID, forKey: "taskID")
        task.setValue(taskText, forKey: "taskText")
        task.setValue(taskState, forKey: "taskState")
        
        saveContext()
        
        // save taskID as a last taskID in UserDefaults
        UserDefaultsManager.saveTaskID(taskID: taskID)
        
    }
    
    func getTasks(completion: @escaping ([Task]?, String) -> Void) {
        
        // retreive all tasks from core data
        
        var tasks: [Task] = [Task]()
        
        do {

            let result = try managedContext.fetch(fetchTasksRequest)
            
            for tasksData in result as! [NSManagedObject] {
                
                let taskID: Int = tasksData.value(forKey: "taskID") as! Int
                let taskText: String = tasksData.value(forKey: "taskText") as! String
                let taskState: String = tasksData.value(forKey: "taskState") as! String
                
                tasks.append(Task(taskID: taskID, taskText: taskText, taskState: taskState))
            
            }
            
            completion(tasks,"")

        } catch {
            completion(nil,"Failed")
        }
        
    }
    
    func removeTask(taskID: Int) {
        
        fetchTasksRequest.predicate = NSPredicate(format: "taskID = %@", "\(taskID)")
        
         do
         {
            let fetchedTasks = try managedContext.fetch(fetchTasksRequest)
             
            let taskToDelete = fetchedTasks[0] as! NSManagedObject
            
            managedContext.delete(taskToDelete)
                        
            saveContext()
                            
         }
         catch
         {
             print(error)
         }

    }
    
    func checkTask(taskID: Int, taskState: String) {
                
        fetchTasksRequest.predicate = NSPredicate(format: "taskID = %@", "\(taskID)")
        do
        {
            let fetchedTasks = try managedContext.fetch(fetchTasksRequest)
        
            let taskToUpdate = fetchedTasks[0] as! NSManagedObject
            taskToUpdate.setValue(taskID, forKey: "taskID")
            taskToUpdate.setValue(taskState, forKey: "taskState")

            saveContext()
            
        }
        catch
        {
            print(error)
        }
        
    }

    func getTasksCount() -> Int{
        do {
            let tasksCount = try managedContext.fetch(fetchTasksRequest).count
            return tasksCount
        } catch {
            return 0
        }
    }
        
    func clearTasks() {
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchTasksRequest)
        do
        {
            try managedContext.execute(deleteRequest)
            
            saveContext()

        }
        catch
        {
            print ("There was an error")
        }
        
    }
    
    func saveContext() {
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
