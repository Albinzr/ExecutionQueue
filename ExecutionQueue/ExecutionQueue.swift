//
//  ExecutionQueue.swift
//  ExecutionQueue
//
//  Created by Albin CR on 4/6/21.
//

import Foundation

open class ExecutionQueue{
    
    public var retryTimer:Double = 0
    public var queue:[Job] = []
    public var queueTimer:Timer?
    public var noOfRetry:Double = 0
    public weak var delegate:ExecutionQueueDelegate?
    
    public init(retryTimer:Double = 0, noOfRetry:Double = 0, startExecution:Bool=false) {
        self.retryTimer = retryTimer
        self.noOfRetry = noOfRetry
        if startExecution { startProcessQueue() }
    }
    
    public func startProcessQueue(){
        
        queueTimer = Timer.scheduledTimer(withTimeInterval: retryTimer, repeats: true, block: { (_)  in
            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                self.processQueue()
            }
        })
        queueTimer?.fire()
    }
    
    public func stopProcessingQueue(){
        queueTimer?.invalidate()
    }
    
    public func clearQueue(){
        queue = []
    }
    
    public func insertToQueue(task:Job){
        queue.append(task)
    }
    
    public func insertToQueue(tasks:[Job]){
        tasks.forEach { (job) in
            queue.append(job)
        }
    }
    
    private func processQueue(){
        if queue.count > 0{
            let task = queue[0]
            if !task.isProcessing {
                task.isProcessing = true
                task.execute { (job) in
                    print("success",job)
                    queue.remove(at: 0)
                    delegate?.sussess(job: job)
                    queueTimer?.fire()
                } failler: { (job) in
                    print("retrying",job)
                    if task.noOfRetry >= noOfRetry  {
                        queue.remove(at: 0)
                        delegate?.failled(job: job)
                        queueTimer?.fire()
                    }else{
                        task.isProcessing = false
                        task.noOfRetry += 1
                        queueTimer?.fire()
                    }
                }
            }
        }
    }
    
    
}
