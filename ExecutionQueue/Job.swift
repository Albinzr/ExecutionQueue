//
//  Job.swift
//  ExecutionQueue
//
//  Created by Albin CR on 4/7/21.
//

import Foundation

open class Job{
    
    public var id:Int = 0
    var noOfRetry:Double = 1
    var isProcessing:Bool = false
    
    public init(id:Int){
        self.id = id
    }
    
    open func execute(success:((Job))->(), failler:(Job)->()){
        
    }
    
}
