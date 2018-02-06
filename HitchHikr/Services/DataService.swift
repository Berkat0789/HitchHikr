//
//  DataService.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/6/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import Foundation
import Firebase
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

    
    
}
