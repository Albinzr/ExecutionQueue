//
//  ExecutionQueueDelegate.swift
//  ExecutionQueue
//
//  Created by Albin CR on 4/7/21.
//

import Foundation

public protocol ExecutionQueueDelegate:class {
    
    //MARK: - success job callback
    func sussess(job:Job)
    
    //MARK: - failled job callback
    func failled(job:Job)
    
}
