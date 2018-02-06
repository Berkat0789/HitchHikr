//
//  LoginVC.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/6/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailField: RoundedtextField!
    @IBOutlet weak var passwordField: RoundedtextField!
    
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
