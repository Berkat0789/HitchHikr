//
//  updateService.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/7/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import Foundation
import Firebase
import MapKit
import UIKit

class UpdateService {
    static let instance = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D, completed: @escaping (_ status: Bool) -> ()) {
        DataService.instance.DB_Reference_Users.observeSingleEvent(of: .value) { (userDataSnapshot) in
            guard let userDataSnapshot = userDataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userDataSnapshot {
                if user.key == Auth.auth().currentUser?.uid {
                    DataService.instance.DB_Reference_Users.child(user.key).updateChildValues(["coordinate": [coordinate.latitude, coordinate.longitude]])
                }
            }//end for loop
        completed(true)
        }//end user observe
    }//end update user location
    
    func updateDriverLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.DB_Reference_Drivers.observeSingleEvent(of: .value) { (driverSnapShot) in
            guard let driverSnapShot = driverSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for driver in driverSnapShot {
                if driver.key == Auth.auth().currentUser?.uid {
                    if driver.childSnapshot(forPath: "driverPickupModeEnabled").value as! Bool == true {
                        DataService.instance.DB_Reference_Drivers.child(driver.key).updateChildValues(["coordinate": [coordinate.latitude, coordinate.longitude]])
                    }
                }
            }//end for loop
        }//end observe drivers
    }//end update driver location
    
    
}//end class
