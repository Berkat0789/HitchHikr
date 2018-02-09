//
//  driverAnnotation.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/8/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import Foundation
import MapKit

class driverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var userID: String!
    
    init(coordinate: CLLocationCoordinate2D, ID: String) {
        self.coordinate = coordinate
        self.userID = ID
        super.init()
    }
    
//Function update annataiton with coordinate
    func positonForAnnotation(annotation: driverAnnotation, coordinate: CLLocationCoordinate2D) {
        var location = self.coordinate
        location.longitude = coordinate.longitude
        location.latitude = coordinate.latitude
        UIView.animate(withDuration: 0.2) {
            self.coordinate = location

        }
    }
}//--end class 
