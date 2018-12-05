//
//  SignInController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy on 12/4/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var myCustomFBLoginButton: UIButton!
    @IBOutlet weak var mTextField_email_signin: UITextField!
    @IBOutlet weak var mTextField_password_signin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myCustomFBLoginButton = FBSDKLoginButton()
        
        //ref = Database.database().reference()
        //storeRef = Storage.storage().reference()
        
        
        
        view.addSubview(myCustomFBLoginButton)
        myCustomFBLoginButton.center = self.view.center;
        myCustomFBLoginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 28)
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        
    }
}

