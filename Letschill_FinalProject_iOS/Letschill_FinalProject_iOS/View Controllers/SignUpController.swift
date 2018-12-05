//
//  SignUpController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Jessica on 12/5/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        }
        
        // Check if password is valid
        if !isPasswordValid(mPassword: mPassword) {
            
            // Display an error message close to the first password text field
        }
        
        // Check if both passwords are the same
        if !doPasswordsMatch(mPasswordOne: mPassword, mPasswordTwo: mRepeatedPassword) {
            
            // Display an error message close to the second password text field
        }
        
        if isEmailValid(mEmail: mEmail) && isPasswordValid(mPassword: mPassword) && doPasswordsMatch(mPasswordOne: mPassword, mPasswordTwo: mRepeatedPassword) {
            
            // Save the user to the database
            
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
        
        if mSplitPasswordNoSpaces.count == mSplitPassword.count { return true }
        
        // Check if password contains at least 6 characters
        if mSplitPasswordNoSpaces.count >= 6 { return true }
        
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
        
        if counterUpperCase > 0 { return true }
        
        // Check if password contains at least 1 number
        if counterNumber > 0 { return true }
        
        // Check if password does not contain special characters
        if counterSpecialChar == 0 { return true }
        
        return false
    }
    
    func doPasswordsMatch(mPasswordOne: String, mPasswordTwo: String) -> Bool {
        
        if mPasswordOne == mPasswordTwo { return true }
        
        return false
    }
}
