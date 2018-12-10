//
//  ForgotPasswordController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Jessica on 12/10/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordController: ViewController {

    // Outlets
    @IBOutlet weak var mTextField_email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        
        // Check if user input is not empty
        if mTextField_email.text != "" {
            
            if let mEmail = mTextField_email.text {
               
                // Request password reset to the database
                Auth.auth().sendPasswordReset(withEmail: mEmail) { (error) in
                    
                    if error == nil {
                        
                        let alert = UIAlertController(title: "Email sent", message: "We've just sent you an email with instructions to reset your password", preferredStyle: UIAlertController.Style.alert)

                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                            
                            // Clear the email TextField
                            self.mTextField_email.text = ""
                            
                            // After resetting the password successfully,
                            // move the user to the SignInController
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        
                        if let mErrorMsg = error {
                            
                            self.showAlert(mTitle: "Oops!", mContent: mErrorMsg as! String)
                        }
                    }
                }
            }
        }
    }
    
    override func showAlert(mTitle: String, mContent: String) {
        
        let alert = UIAlertController(title: mTitle, message: mContent, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dismissScreen(_ sender: UIBarButtonItem) {
        
        // Return to SignInController
        self.dismiss(animated: true, completion: nil)
    }
}
