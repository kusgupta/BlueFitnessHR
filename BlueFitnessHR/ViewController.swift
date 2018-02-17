//
//  ViewController.swift
//  BlueFitnessHR
//
//  Created by Kushan Gupta on 2/4/18.
//  Copyright © 2018 KBStudios. All rights reserved.
//

import UIKit
import HealthKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    let healthKitManager = HealthKitManager.sharedInstance
    
    var datasource: [HKQuantitySample] = []
    
    var heartRateQuery: HKQuery?

    var myDatabase: DatabaseReference!
    
    var currentVal = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        healthKitManager.authorizeHealthKit { (success, error) in
            print("Was healthkit successful? \(success)")
            self.retrieveHeartRateData()
        }
        myDatabase = Database.database().reference()
        while (true){
            self.myDatabase.child("heartrate").setValue((addAnum(prevNum: 1)))
        }
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func retrieveHeartRateData() {
        if let query = healthKitManager.createHeartRateStreamingQuery(Date()){
            self.heartRateQuery = query
            self.healthKitManager.heartRateDelegate = self
            self.healthKitManager.healthStore.execute(query)
        }
        
    }
    
    func addAnum(prevNum: Double) -> Double {
        return prevNum + 1
    }
}
    
    extension ViewController: HeartRateDelegate {
        func heartRateUpdated(heartRateSamples: [HKSample]){
            guard let heartRateSamples = heartRateSamples as?[HKQuantitySample] else{
                return
            }
            DispatchQueue.main.async {
                self.datasource.append(contentsOf: heartRateSamples)
            }
        }
}

