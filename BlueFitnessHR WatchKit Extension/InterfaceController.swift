//
//  InterfaceController.swift
//  BlueFitnessHR WatchKit Extension
//
//  Created by Kushan Gupta on 2/4/18.
//  Copyright © 2018 KBStudios. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit


class InterfaceController: WKInterfaceController {
    
    var workoutSession: HKWorkoutSession?
    
    @IBOutlet var heartRateLabel: WKInterfaceLabel!
    
    var isWorkoutInProgress = false
    
    @IBOutlet var workoutButton: WKInterfaceButton!
    
    let healthKitManager = HealthKitManager.sharedInstance
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        self.workoutButton.setEnabled(false)
        
        // Configure interface objects here.
        healthKitManager.authorizeHealthKit { (success, error) in
            print("Was healthkit successful? \(success)")
            
            self.workoutButton.setEnabled(true)
            
            self.createWorkoutSession()
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
        if isWorkoutInProgress {
            print("End workout")
            endWorkoutSession()
        } else {
            print("Start workout")
            startWorkoutSession()
        }
        isWorkoutInProgress = !isWorkoutInProgress
        self.workoutButton.setTitle(isWorkoutInProgress ? "End Workout" : "Start Workout")
        print("button tapped")
    }
    
    func createWorkoutSession() {
        
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .other
        workoutConfiguration.locationType = .unknown
        
        do {
        workoutSession = try HKWorkoutSession(configuration: workoutConfiguration)
        } catch {
            print("Exception thrown")
        }
    }
    
    func startWorkoutSession() {
        
        if self.workoutSession == nil {
            createWorkoutSession()
        }
        guard let session = workoutSession else {
            print("Cannot start a workout without a workout session")
            return
        }
        
        healthKitManager.healthStore.start(session)
    }
    
    func endWorkoutSession() {
        guard let session = workoutSession else {
            print("Cannot start a workout without a workout session")
            return
        }
        healthKitManager.healthStore.end(session)
        
    }
}

