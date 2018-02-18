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
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate{
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?){
    
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    let healthKitManager = HealthKitManager.sharedInstance
    
    var datasource: [HKQuantitySample] = []
    
    var heartRateQuery: HKQuery?
    
    var myDatabase: DatabaseReference!
    
    var currentVal = 1
    
    var haha = 1.0
    
    var session: WCSession!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        healthKitManager.authorizeHealthKit { (success, error) in
            print("Was healthkit successful? \(success)")
            self.retrieveHeartRateData()
        }
        if (WCSession.isSupported()) {
            session = WCSession.default
            session.delegate = self;
            session.activate()
        }
        self.myDatabase = Database.database().reference()
        
        
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
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let heartrate = message["heartrate"] as? String
        
        //Use this to update the UI instantaneously (otherwise, takes a little while)
        DispatchQueue.main.async() {
            self.myDatabase.child("heartrate").setValue(heartrate!)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]){
        let heartRateValue = message["heartrate"] as? String
        
        DispatchQueue.main.async() {
            self.myDatabase.child("heartrate").setValue(heartRateValue!)
        }
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

extension UIViewController {
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
    }
}

