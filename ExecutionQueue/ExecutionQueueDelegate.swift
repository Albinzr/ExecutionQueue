//
//  ExecutionQueueDelegate.swift
//  ExecutionQueue
//
//  Created by Albin CR on 4/7/21.
//

import Foundation

public protocol ExecutionQueueDelegate:class {
    func sussess(job:Job)
    func failled(job:Job)
}
