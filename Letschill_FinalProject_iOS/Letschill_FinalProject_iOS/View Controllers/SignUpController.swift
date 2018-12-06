//
//  SignUpController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy in collaboration with Jessica de Oliveira on 12/4/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpController: ViewController {

    // Outlets
    @IBOutlet weak var mTextField_username: UITextField!
    @IBOutlet weak var mTextField_email: UITextField!
    @IBOutlet weak var mTextField_password: UITextField!
    @IBOutlet weak var mTextField_repeatPassword: UITextField!
    
    // Variables
    var mUsername: String = ""
    var mEmail: String = ""
    var mPassword: String = ""
    var mRepeatedPassword: String = ""
    var mDBReference: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // FirebaseApp.configure() cannot be called twice. It's called in appDelegate init already.
        // Check if it's nil before.
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // Setting the reference for writing and reading data from the database (realtime)
        mDBReference = Database.database().reference()
    }

    @IBAction func signUp(_ sender: UIButton) {
        
        // Retrieve user input from all the text fields
        mUsername = mTextField_username.text ?? " "
        mEmail = mTextField_email.text ?? " "
        mPassword = mTextField_password.text ?? " "
        mRepeatedPassword = mTextField_repeatPassword.text ?? " "
        
        // Check if email is a valid type
        if !isEmailValid(mEmail: mEmail) {
            
            // Display an error message close to the email text field
            print("Email not valid")
        }
        
        // Check if password is valid
        if !isPasswordValid(mPassword: mPassword) {
            
            // Display an error message close to the first password text field
        }
        
        // Check if both passwords are the same
        if !doPasswordsMatch(mPasswordOne: mPassword, mPasswordTwo: mRepeatedPassword) {
            
            // Display an error message close to the second password text field
            print("Passwords do not match")
        }
        
        if isEmailValid(mEmail: mEmail) && isPasswordValid(mPassword: mPassword) && doPasswordsMatch(mPasswordOne: mPassword, mPasswordTwo: mRepeatedPassword) {
            
            // Save the user to the database
            Auth.auth().createUser(withEmail: mEmail, password: mPassword) { (createdUser, error) in
                
                // If successful, check if createdUser is nil
                if let user = createdUser {
                    
                    // Save the extra user info to the Realtime database
                    self.mDBReference?.child("Users").child(user.user.uid).setValue(["username":self.mUsername, "email":self.mEmail])
                    
                    // Clean up the text fields
                    self.cleanTextFields()
                    
                    // Perform a segue to the "interests" screen
                    print("You're signed in!")
                    
                } else {
                    
                    // Check error and show message
                    if error != nil {
                        if let errorMessage = error?.localizedDescription {
                            print("Error: \(String(describing: errorMessage))")
                            self.showAlert(mTitle: "Oops!", mContent: errorMessage)
                        }
                        
                    }
                }
            }
        }
    }
    
    func isEmailValid(mEmail:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: mEmail)
    }
    
    func isPasswordValid(mPassword: String) -> Bool {
        
        // Check if password contains spaces
        let mSplitPassword = Array(mPassword)
        let mSplitPasswordNoSpaces = mPassword.components(separatedBy: " ")
        
        if mSplitPasswordNoSpaces.count == mSplitPassword.count { return true } else { print("Password must not contain spaces") }
        
        // Check if password contains at least 6 characters
        if mSplitPasswordNoSpaces.count >= 6 { return true } else { print("Password must have at least 6 characters") }
        
        // Check if password contains at least 1 uppercased letter
        var counterUpperCase = 0
        var counterNumber = 0
        var counterSpecialChar = 0
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        
        for i in mSplitPasswordNoSpaces {
            
            if i == i.uppercased() { counterUpperCase+=1 }
            
            if i.rangeOfCharacter(from: .decimalDigits) != nil { counterNumber+=1 }
            
            if i.rangeOfCharacter(from: characterset.inverted) != nil { counterSpecialChar+=1 }
        }
        
        // Check if password contains at least 1 uppercased letter
        if counterUpperCase > 0 { return true } else { print("Password must contain at least 1 uppercased letter") }
        
        // Check if password contains at least 1 number
        if counterNumber > 0 { return true } else { print("Password must contain at least 1 number") }
        
        // Check if password does not contain special characters
        if counterSpecialChar == 0 { return true } else { print("Password cannot contain special characters") }
        
        return false
    }
    
    func doPasswordsMatch(mPasswordOne: String, mPasswordTwo: String) -> Bool {
        
        if mPasswordOne == mPasswordTwo { return true }
        
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Dismiss keyboard when the view is tapped on
        mTextField_username.resignFirstResponder()
        mTextField_email.resignFirstResponder()
        mTextField_password.resignFirstResponder()
        mTextField_repeatPassword.resignFirstResponder()
    }
    
    @IBAction func dismissCurrentScreen(_ sender: UIBarButtonItem) {
        
        // Return to Sign In screen
        self.dismiss(animated: true, completion: nil)
    }
    
    override func cleanTextFields() {
        
        mTextField_username.text = ""
        mTextField_email.text = ""
        mTextField_password.text = ""
        mTextField_repeatPassword.text = ""
    }
    
    override func showAlert(mTitle: String, mContent: String) {
        
        let alert = UIAlertController(title: mTitle, message: mContent, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
