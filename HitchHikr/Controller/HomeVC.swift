//
//  HomeVC.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/5/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapview.delegate = self

    }//--End view did load

}//end controller 
