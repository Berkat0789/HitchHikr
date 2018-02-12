//
//  locationCell.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/11/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
import MapKit

class locationCell: UITableViewCell {
    
    @IBOutlet weak var searchResultText: UILabel!
    
    @IBOutlet weak var locationDetail: UILabel!
    
    func uodateCell (locationText: MKMapItem, locationDetail: MKMapItem) {
        self.searchResultText.text = locationText.name
        self.locationDetail.text = locationDetail.placemark.title
    }

}
