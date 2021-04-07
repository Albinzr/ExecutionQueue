//
//  ViewController.swift
//  qt
//
//  Created by Albin CR on 4/6/21.
//

import UIKit
import ExecutionQueue

class ViewController: UIViewController {

    let q = ExecutionQueue.init(retryTimer: 10, noOfRetry: 3, startExecution: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
            
        q.delegate = self
    
        let at0 = JobTest(id: 10)
        let at1 = JobTest(id: 11)
        let at2 = JobTest(id: 12)
        let at3 = JobTest(id: 13)
        
        q.insertToQueue(task: at0)
        q.insertToQueue(task: at1)
        q.insertToQueue(task: at2)
        q.insertToQueue(task: at3)
        

    }
    
}


extension ViewController: ExecutionQueueDelegate{
    func sussess(job: Job) {
        print("success-----------",job.id)
    }
    
    func failled(job: Job) {
        print("failled after all retry----------",job.id)
    }
}

class JobTest:Job{

    override init(id:Int) {
        super.init(id: id)
    }
    
    
    override func execute(success: ((Job)) -> (), failler: (Job) -> ()) {
        success(self)
    }
}

