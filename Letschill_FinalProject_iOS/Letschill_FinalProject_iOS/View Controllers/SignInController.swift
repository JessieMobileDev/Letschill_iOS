//
//  SignInController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy in collaboration with Jessica de Oliveira on 12/4/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var myCustomFBLoginButton: UIButton!
    @IBOutlet weak var mTextField_email_signin: UITextField!
    @IBOutlet weak var mTextField_password_signin: UITextField!
    @IBOutlet weak var mLabel_signUp: UILabel!
    @IBOutlet weak var mLabel_forgotPassword: UILabel!
    @IBOutlet weak var mSwitch_rememberMe: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Uncomment the code below once the Main Screen is done
//        if isSignedIn() {
//            performSegue(withIdentifier: "moveToMainScreenIdentifier", sender: self)
//        }
        
        // FirebaseApp.configure() cannot be called twice. It's called in appDelegate init already.
        // Check if it's nil before.
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // assign the custom button to default Facebook SDK Login Button
        myCustomFBLoginButton = FBSDKLoginButton()
        
        // view the button
        view.addSubview(myCustomFBLoginButton)
        myCustomFBLoginButton.center = self.view.center;
        
        // position the facebook button based on the height and width of the frame
        myCustomFBLoginButton.frame = CGRect(x: 32, y: view.frame.height - 95, width: view.frame.width - 60, height: 32)
        
        myCustomFBLoginButton = FBSDKLoginButton()
        
        
        
        // Allow sign up label respond to user taps
        let mSignUpTapAction = UITapGestureRecognizer(target: self, action: #selector(self.noAccountTapped(_:)))
        mLabel_signUp?.isUserInteractionEnabled = true 
        mLabel_signUp?.addGestureRecognizer(mSignUpTapAction)
        
        // Allow "forgot password" label respond to user taps
        let mForgotPasswordTapAction = UITapGestureRecognizer(target: self, action: #selector(self.forgotPasswordTapped(_:)))
        mLabel_forgotPassword?.isUserInteractionEnabled = true
        mLabel_forgotPassword?.addGestureRecognizer(mForgotPasswordTapAction)
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        
        // Check if user entries are not empty
        if let mEmail = mTextField_email_signin.text, let mPassword = mTextField_password_signin.text {
            
            // Verify if user exist and perform segue to "main screen"
            Auth.auth().signIn(withEmail: mEmail, password: mPassword) { (createdUser, error) in
                
                // If successful, check if createdUser is not nil
                if createdUser != nil {
                    
                    if self.mSwitch_rememberMe.isOn {
                        
                        // Save the login instance state to user defaults
                        UserDefaults.standard.set(true, forKey: "isSignedIn")
                        UserDefaults.standard.synchronize()
                    }
                    
                    // Perform a segue to the "interests" screen
                    print("You're signed in!")
                    self.showAlert(mTitle: "Signed In", mContent: "You're signed in!")
                    
                } else {
                    
                    // Check error and show message
                    print("User does not exist")
                }
            }
        } else {
            
            // Display error message about empty entries
            print("Don't leave empty fields")
        }
    }
    
    @objc func noAccountTapped(_ sender: UITapGestureRecognizer) {
        
        // When the "create a new account" label is tapped, perform a segue to the sign up screen
        performSegue(withIdentifier: "signUpIdentifier", sender: self)
    }
    
    @objc func forgotPasswordTapped(_ sender: UITapGestureRecognizer) {
        
        // Move to the ForgotPasswordController
        performSegue(withIdentifier: "forgotPasswordIdentifier", sender: self)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Dismiss keyboard when the view is tapped on
        mTextField_email_signin.resignFirstResponder()
        mTextField_password_signin.resignFirstResponder()
    }
    
    func cleanTextFields() {
        
        mTextField_email_signin.text = ""
        mTextField_password_signin.text = ""
    }
    
    func showAlert(mTitle: String, mContent: String) {
        
        let alert = UIAlertController(title: mTitle, message: mContent, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isSignedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isSignedIn")
    }
    
}

