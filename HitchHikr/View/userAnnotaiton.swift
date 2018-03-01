//
//  userAnnotaiton.swift
//  HitchHikr
//
//  Created by berkat bhatti on 3/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import Foundation
import Firebase
import MapKit

class userAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var userID: String!
    
    
    init(coordinat: CLLocationCoordinate2D, ID: String) {
        self.coordinate = coordinat
        self.userID = ID
        super.init()
    }
}
