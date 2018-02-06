//
//  hamburgerMenuVC.swift
//  HitchHikr
//
//  Created by berkat bhatti on 2/6/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit

class hamburgerMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 40

    }//--end controller
    
//--Actions
    @IBAction func signUpPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
        
    }
    

}
