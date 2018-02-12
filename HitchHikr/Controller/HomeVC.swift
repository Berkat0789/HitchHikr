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
import Firebase
import RevealingSplashView

class HomeVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var centerMapButton: UIButton!
    @IBOutlet weak var destinationTextield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    //--Variables and arrays
    var locationManager = CLLocationManager()
    var locationAuth  = CLLocationManager.authorizationStatus()
    var locationRadius: Double = 1000
    var driverAnnotation: MKAnnotation!
    
    var MatchItem: [MKMapItem] = [MKMapItem]()
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        destinationTextield.delegate = self
        AuthorizeLocationService()
    
        
        DataService.instance.DB_Reference_Drivers.observe(.value) { (DriverSnap) in
            DataService.instance.getDriverCoordinateforAnnotation { (returnedDriverAnnotaton) in
                guard let DriverSnap = DriverSnap.children.allObjects as? [DataSnapshot] else {return}
                
                for driver in DriverSnap {
                    if driver.childSnapshot(forPath: "driverPickupModeEnabled").value as! Bool == false {
                        for annotation in self.mapview.annotations {
                            self.mapview.removeAnnotation(annotation)
                        }
                    }
                }//--end for loop
                self.driverAnnotation = returnedDriverAnnotaton
                self.mapview.addAnnotation(self.driverAnnotation)
            }
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MatchItem.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? locationCell else {return UITableViewCell()}
        let searchResults = MatchItem[indexPath.row]
        cell.locationDetail.text = searchResults.name
        cell.searchResultText.text = searchResults.placemark.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("location Selected")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == destinationTextield {
            tableView.isHidden = false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == destinationTextield {
            performSearch()
        }
        self.view.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        MatchItem = []
        self.tableView.reloadData()
        GetUserCurrentLocation()
        return true
    }
    
//--Actions

    @IBAction func centerUserLocationPressed(_ sender: Any) {
        GetUserCurrentLocation()
    }
    //Gestures and animatons
    
//--Selectors
    
//--View update functions
    func performSearch() {
        MatchItem.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = destinationTextield.text
        request.region = mapview.region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else if response?.mapItems.count == 0 {
                print("no results Found")
            } else {
                for mapitems in response!.mapItems {
                    self.MatchItem.append(mapitems as MKMapItem)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
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
