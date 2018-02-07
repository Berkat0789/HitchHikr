//
//  hamburgerMenuVC.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/6/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
import Firebase

class hamburgerMenuVC: UIViewController {
//Outlet
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var AccountType: UILabel!
    @IBOutlet weak var userPRofile: roundedImage!
    @IBOutlet weak var pickupModeSttus: UILabel!
    @IBOutlet weak var switchSatus: UISwitch!
    @IBOutlet weak var loginButton: UIButton!
//--Variables and array
    let currentuserID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 40

    }//--end controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchSatus.isOn = false
        switchSatus.isHidden = true
        pickupModeSttus.isHidden = true
        
        observeRidersandDrivers()
        
        if Auth.auth().currentUser == nil {
            userEmail.text = ""
            AccountType.text = ""
            userPRofile.isHidden = true
            loginButton.setTitle("Sign Up/ Login", for: .normal)
        }else {
            userEmail.text = Auth.auth().currentUser?.email
            userPRofile.isHidden = false
            AccountType.text = ""
            loginButton.setTitle("logout", for: .normal)
        }
        
    }
//--View functions
    func observeRidersandDrivers() {
     //--Observe Users(Riders)
        DataService.instance.DB_Reference_Users.observeSingleEvent(of: .value) { (userDataSnapShot) in
            guard let userSnapShot = userDataSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userSnapShot {
                if user.key == Auth.auth().currentUser?.uid {
                    self.AccountType.text = "Rider"
            }
        }//end for loop
            
    }//end database observe
   //--Observe Drivers
        DataService.instance.DB_Reference_Drivers.observeSingleEvent(of: .value) { (DriverSnapShot) in
            guard let DriverSnapShot = DriverSnapShot.children.allObjects as? [DataSnapshot] else {return}
            
            for driver in DriverSnapShot {
                let switchStatus = driver.childSnapshot(forPath: "driverPickupModeEnabled").value as! Bool
                if driver.key == Auth.auth().currentUser?.uid {
                    self.AccountType.text = "Driver"
                    self.switchSatus.isHidden = false
                    self.switchSatus.isOn = switchStatus
                    self.pickupModeSttus.isHidden = false
                    
                }
            }//end for loop
        }//end driver observe
    
}//-- end observe riders and drivers
    
    
//--Actions
    
    @IBAction func switchToggled(_ sender: Any) {
        if switchSatus.isOn {
            pickupModeSttus.text = "Pickup mode enabled"
            DataService.instance.DB_Reference_Drivers.child(currentuserID!).updateChildValues(["driverPickupModeEnabled" : true])
            self.revealViewController().revealToggle(animated: true)
        }else {
            pickupModeSttus.text = "Pickup mode Off"
            DataService.instance.DB_Reference_Drivers.child(currentuserID!).updateChildValues(["driverPickupModeEnabled" : false])
            self.revealViewController().revealToggle(animated: true)
        }
    }
    @IBAction func signUpPressed(_ sender: Any) {
    if Auth.auth().currentUser == nil {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }else {
        let logoutAlert = UIAlertController(title: "Logout", message: "Are you sure you want to logout", preferredStyle: .alert)
        logoutAlert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (Logout) in
            do {
                try Auth.auth().signOut()
                self.userEmail.text = ""
                self.AccountType.text = ""
                self.userPRofile.isHidden = true
                self.switchSatus.isHidden = true
                self.pickupModeSttus.text = ""
                self.loginButton.setTitle("Signup/Login", for: .normal)
            } catch let error as NSError{
                print(error)
            }
        }))
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(logoutAlert, animated: true, completion: nil)
    }
}//end signup pressed
    

}
