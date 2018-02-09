//
//  DataService.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/6/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import Foundation
import Firebase
import MapKit
let FirebaseReference = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private(set) public var DB_Reference = FirebaseReference
    private(set) public var DB_Reference_Users = FirebaseReference.child("user")
    private(set) public var DB_Reference_Drivers = FirebaseReference.child("drivers")
    private(set) public var DB_Reference_trips = FirebaseReference.child("trips")

    func createDBUser(uid: String, userData: Dictionary<String, Any>, isDriver: Bool) {
        if isDriver {
            DB_Reference_Drivers.child(uid).updateChildValues(userData)
        } else {
            DB_Reference_Users.child(uid).updateChildValues(userData)
        }
        
    }//--end createDBUser

//--Get user Location
    
    func getDriverCoordinateforAnnotation(completed: @escaping (_ annotation: MKAnnotation ) -> ()) {
        var Driverannotaiton: MKAnnotation!
        DB_Reference_Drivers.observeSingleEvent(of: .value) { (driverSnap) in
            guard let driverSnap = driverSnap.children.allObjects as? [DataSnapshot] else {return}
            
            for driver in driverSnap {
                if driver.hasChild("coordinate") {
                    guard let driverDict = driver.value as? Dictionary<String, Any> else {return}
                    let coordinateArray = driverDict["coordinate"] as! NSArray
                    let driverCoordinate = CLLocationCoordinate2D(latitude: coordinateArray[0] as! CLLocationDegrees, longitude: coordinateArray[1] as! CLLocationDegrees)
                    let driverAnno = driverAnnotation(coordinate: driverCoordinate, ID: driver.key)
                    Driverannotaiton = driverAnno
                }
            }//end loop
            completed(Driverannotaiton)
        }//--End observe
        
        
    }
    
}//End class
