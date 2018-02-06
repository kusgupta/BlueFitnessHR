//
//  HealthKitManager.swift
//  BlueFitnessHR WatchKit Extension
//
//  Created by Kushan Gupta on 2/5/18.
//  Copyright © 2018 KBStudios. All rights reserved.
//
import Foundation
import HealthKit

class HealthKitManager: NSObject {
    
    static let sharedInstance = HealthKitManager()
    
    private override init() {}
    
    let healthStore = HKHealthStore()
    
    func authorizeHealthKit(_ completion: @escaping ((_ success: Bool, _ error: Error?) -> Void)) {
        
        guard let heartRateType: HKQuantityType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            return
        }
        let typesToShare = Set([HKObjectType.workoutType(), heartRateType])
        let typesToRead = Set([HKObjectType.workoutType(), heartRateType])
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            print("Was authorization successful? \(success)")
            completion(success, error)
        }
    }
}

