//
//  ViewController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy on 12/4/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginButton = FBSDKLoginButton()
        
        //ref = Database.database().reference()
        //storeRef = Storage.storage().reference()
        
        
        
        view.addSubview(loginButton)
        loginButton.center = self.view.center;
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 28)
    }


}

