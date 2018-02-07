//
//  LoginVC.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/6/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailField: RoundedtextField!
    @IBOutlet weak var passwordField: RoundedtextField!
    @IBOutlet weak var segmantedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        self.view.bindToKeyboard()
        tapToDismissKeyboard()

    }//
//-Protocol related functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        return true
    }

//--Actions
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func login_sognupPresed(_ sender: Any) {
        guard let email = emailField.text, emailField.text != "" else {return}
        guard let password = passwordField.text, passwordField.text != "" else{return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                guard let errorCode = AuthErrorCode(rawValue: error!._code) else {return}
                switch errorCode {
                case .emailAlreadyInUse:
                    print("email already in use")
                case .weakPassword:
                    print("password needs to be 8 or more characters")
                case .invalidEmail:
                    print("email is invalid")
                default:
                    print("Please check credentials and try again")
                }
                
            }else {
                if self.segmantedControl.selectedSegmentIndex == 0 {
                    let userData = ["providerID" : (user?.providerID)!, "email" :email]
                    DataService.instance.createDBUser(uid: (user?.uid)!, userData: userData, isDriver: false)
                }else {
                    //Segmented is 1(Driver)
                    let userData = ["providerID" : (user?.providerID)!, "email" :email, "useriSDriver": true,"userOnTrip" : false,"driverPickupModeEnabled" : false] as [String: Any]
                    DataService.instance.createDBUser(uid: (user?.uid)!, userData: userData, isDriver: true)
                }
            }
            self.dismiss(animated: true, completion: nil)
            print("User created with Firebase")
        }//end Auth create user
        
       
        
    }//end login signup preseed
    
//--Gestures and animations
    func tapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(taptoDismiss(_:)))
        self.view.addGestureRecognizer(tap)
    }
//--Selctors
    @objc func taptoDismiss(_ Recon: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
}
