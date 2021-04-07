//
//  ViewController.swift
//  qt
//
//  Created by Albin CR on 4/6/21.
//

import UIKit
import ExecutionQueue

class ViewController: UIViewController,ExecutionQueueDelegate {
    func sussess(job: Job) {
        print("success-----------",job)
    }
    
    func failled(job: Job) {
        print("faill----------",job)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
    
        let q = ExecutionQueue.init(retryTimer: 3, noOfRetry: 3, startExecution: true)
        q.delegate = self
        let at = Test(id: 10)
        q.insertToQueue(task: at)

    }
    
}

class Test:Job{
    
    
    override init(id:Int) {
        super.init(id: id)
    }
    
    
    override func execute(success: ((Job)) -> (), failler: (Job) -> ()) {
        success(self)
    }
}

