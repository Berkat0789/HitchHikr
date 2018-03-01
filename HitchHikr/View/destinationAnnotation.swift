//
//  destinationAnnotation.swift
//  HitchHikr
//
//  Created by berkat bhatti on 3/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import Foundation
import MapKit

class destinationAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var id: String!
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.id = identifier
        super.init()
    }
    
    
}
