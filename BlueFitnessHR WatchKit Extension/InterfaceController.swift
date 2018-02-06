//
//  InterfaceController.swift
//  BlueFitnessHR WatchKit Extension
//
//  Created by Kushan Gupta on 2/4/18.
//  Copyright © 2018 KBStudios. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var heartRateLabel: WKInterfaceLabel!
    
    @IBOutlet var workoutButton: WKInterfaceButton!
    let healthKitManager = HealthKitManager.sharedInstance
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        healthKitManager.authorizeHealthKit { (success, error) in
            print("Was healthkit successful? \(success)")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func startOrStopWorkout() {
        print("button tapped")
    }
}

