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
import RevealingSplashView

class HomeVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var menuButton: UIButton!

//--Variables and arrays
    var locationManager = CLLocationManager()
    var locationAuth  = CLLocationManager.authorizationStatus()
    var locationRadius: Double = 1000
    var driverAnnotation: MKAnnotation!
    
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        revealingSplashView.startAnimation()
        revealingSplashView.heartAttack = true
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        mapview.delegate = self
        AuthorizeLocationService()
        
        DataService.instance.getDriverCoordinateforAnnotation { (returnedDriverAnnotaton) in
            self.driverAnnotation = returnedDriverAnnotaton
            self.mapview.addAnnotation(self.driverAnnotation)
        }
    }//--End view did load
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if locationAuth == .authorizedAlways || locationAuth == .authorizedWhenInUse {
            GetUserCurrentLocation()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
//--Protocol conforming function
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        GetUserCurrentLocation()
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation = annotation as? driverAnnotation
        let identifier = "driver"
        let view: MKAnnotationView
        view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.image = UIImage(named: "driverAnnotation")
        return view
    }
    
//--Actions

    @IBAction func centerUserLocationPressed(_ sender: Any) {
        GetUserCurrentLocation()
    }
    //Gestures and animatons
    
//--Selectors
    
//--View update functions
    
    func AuthorizeLocationService() {
        if locationAuth == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    func GetUserCurrentLocation() {
        guard let usercurrentLocation = locationManager.location?.coordinate else{return}
        let userLocationRaduis = MKCoordinateRegionMakeWithDistance(usercurrentLocation, locationRadius * 2.0, locationRadius * 2.0)
        mapview.setRegion(userLocationRaduis, animated: true)
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        UpdateService.instance.updateUserLocation(withCoordinate: userLocation.coordinate) { (true) in
            //
        }
        UpdateService.instance.updateDriverLocation(withCoordinate: userLocation.coordinate)
    }
    


}//end controller 
