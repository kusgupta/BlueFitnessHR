//
//  ViewController.swift
//  BlueFitnessHR
//
//  Created by Kushan Gupta on 2/4/18.
//  Copyright © 2018 KBStudios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     let healthKitManager = HealthKitManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        healthKitManager.authorizeHealthKit { (success, error) in
            print("Was healthkit successful? \(success)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

