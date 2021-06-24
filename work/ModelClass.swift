//
//  ModelClass.swift
//  work
//
//  Created by Apple on 24/06/2021.
//

import Foundation

class ModelClass : NSObject, Codable {
    
    var taskName : String
    var taskStatus : Bool = false
    
    init(taskName : String , taskStatus : Bool) {
        self.taskName = taskName
        self.taskStatus = taskStatus
    }
    
    init(taskName : String ) {
        self.taskName = taskName
    }
    
    func getName () -> String
    {
        return taskName
    }
    
    
    func getStatus () -> Bool
    {
        return taskStatus
    }
}
