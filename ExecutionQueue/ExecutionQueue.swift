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
    public var threadType:DispatchQoS.QoSClass = DispatchQoS.QoSClass.background
    public weak var delegate:ExecutionQueueDelegate?
    
    
    public init(
        retryTimer:Double = 0,
        noOfRetry:Double = 0,
        startExecution:Bool=false,
        threadType:DispatchQoS.QoSClass = DispatchQoS.QoSClass.background
    )
    {
        self.retryTimer = retryTimer
        self.noOfRetry = noOfRetry
        self.threadType = threadType
        if startExecution { startProcessQueue() }
    }
    
    //MARK: - startProcessQueue
    public func startProcessQueue(){
        
        queueTimer =  Timer.init(timeInterval: retryTimer, target: self, selector: #selector(run), userInfo: nil, repeats: true)
        queueTimer = Timer.scheduledTimer(withTimeInterval: retryTimer, repeats: true, block: { [weak self] (_)   in
            guard let self = self else { return }
            DispatchQueue.global(qos: self.threadType).async {
                self.processQueue()
            }
        })
        queueTimer?.fire()
    }
    
    @objc private func run(){
        DispatchQueue.global(qos: threadType).async {
            self.processQueue()
        }
    }
    
    //MARK: - stopProcessingQueue
    public func stopProcessingQueue(){
        queueTimer?.invalidate()
    }
    
    //MARK: - clearQueue
    public func clearQueue(){
        queue = []
    }
    
    //MARK: - insertToQueue
    public func insertToQueue(task:Job){
        queue.append(task)
    }
    
    //MARK: - insert multiple items in To Queue
    public func insertToQueue(tasks:[Job]){
        tasks.forEach { (job) in
            queue.append(job)
        }
    }
    
    private func executeNext(){
        queueTimer?.invalidate()
        startProcessQueue()
    }
    
    //MARK: - processQueue
    private func processQueue(){
        if queue.count > 0{
            let task = queue[0]
            if !task.isProcessing {
                task.isProcessing = true
                task.execute { (job) in
                    queue.remove(at: 0)
                    delegate?.sussess(job: job)
                    executeNext()
                } failler: { (job) in
                    if task.noOfRetry >= noOfRetry  {
                        queue.remove(at: 0)
                        delegate?.failled(job: job)
                        executeNext()
                    }else{
                        task.isProcessing = false
                        task.noOfRetry += 1
                        executeNext()
                    }
                }
            }
        }
    }
    
    
}
