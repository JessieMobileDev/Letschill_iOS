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

class ViewController: UIViewController, FBSDKLoginButtonDelegate {


    // Outlets
    @IBOutlet weak var myCustomFBLoginButtonOne: UIButton!
    @IBOutlet weak var mTextField_email_signin: UITextField!
    @IBOutlet weak var mTextField_password_signin: UITextField!
    @IBOutlet weak var mLabel_signUp: UILabel!
    @IBOutlet weak var mLabel_forgotPassword: UILabel!
    @IBOutlet weak var mSwitch_rememberMe: UISwitch!
    
    // Variables
    //myCustomFBLoginButton: FBSDKLoginButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Uncomment the code below once the Main Screen is done
        if isSignedIn() {
            performSegue(withIdentifier: "moveToMainScreenIdentifier", sender: self)
        }
        
        // FirebaseApp.configure() cannot be called twice. It's called in appDelegate init already.
        // Check if it's nil before.
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // assign the custom button to default Facebook SDK Login Button
        let myCustomFBLoginButton = FBSDKLoginButton()
        
        // display the button
        view.addSubview(myCustomFBLoginButton)
        myCustomFBLoginButton.center = self.view.center;
        
        // position the facebook button based on the height and width of the frame
        myCustomFBLoginButton.frame = CGRect(x: 32, y: view.frame.height - 95, width: view.frame.width - 60, height: 32)

        myCustomFBLoginButton.delegate = self
        //myCustomFBLoginButton = FBSDKLoginButton()
        
        
    
        // Resize the Switch button
        if mSwitch_rememberMe != nil {
            
          mSwitch_rememberMe.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        }
        
        
        // Allow sign up label respond to user taps
        let mSignUpTapAction = UITapGestureRecognizer(target: self, action: #selector(self.noAccountTapped(_:)))
        mLabel_signUp?.isUserInteractionEnabled = true 
        mLabel_signUp?.addGestureRecognizer(mSignUpTapAction)
        
        // Allow "forgot password" label respond to user taps
        let mForgotPasswordTapAction = UITapGestureRecognizer(target: self, action: #selector(self.forgotPasswordTapped(_:)))
        mLabel_forgotPassword?.isUserInteractionEnabled = true
        mLabel_forgotPassword?.addGestureRecognizer(mForgotPasswordTapAction)
    }
    
    var fbLoginSuccess = false
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil && fbLoginSuccess == true)
        {
            performSegue(withIdentifier: "moveToMainScreenIdentifier", sender: self)
        }
    }
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        print("User Logged In")
        
        if ((error) != nil) {
            // Process error
            print(error)
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            fbLoginSuccess = true
             self.showAlert(mTitle: "Signed In", mContent: "You're signed in!")
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email") {
                // Do work
               // performSegue(withIdentifier: "loginSegue", sender: self)
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        self.showAlert(mTitle: "Signed Out", mContent: "You're signed out!")
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
                        //performSegue(withIdentifier: String, sender: Any?)
                    }
                    
                    // Perform a segue to the "interests" screen
                    print("You're signed in!")
                    self.showAlert(mTitle: "Signed In", mContent: "You're signed in!")
                    
                   self.performSegue(withIdentifier: "moveToMainScreenIdentifier", sender: self)
                    
                    
                    
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
        
       // performSegue(withIdentifier: "emailSignInSucessToMain", sender: self)
        return UserDefaults.standard.bool(forKey: "isSignedIn")
    }
}

