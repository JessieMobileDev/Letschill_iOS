//
//  CreateEventController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Jessica on 12/23/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CreateEventController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var mPicker_category: UIPickerView!
    @IBOutlet weak var mImageView_eventImage: UIImageView!
    @IBOutlet weak var mTextField_eventName: UITextField!
    @IBOutlet weak var mTextField_location: UITextField!
    @IBOutlet weak var mTextField_eventDate: UITextField!
    @IBOutlet weak var mTextField_startTime: UITextField!
    @IBOutlet weak var mTextField_endTime: UITextField!
    @IBOutlet weak var mTextField_description: UITextField!
    @IBOutlet weak var mTextField_participants: UITextField!
    @IBOutlet weak var mButton_location: UIImageView!
    @IBOutlet weak var mSwitch_recurring: UISwitch!
    @IBOutlet weak var mSwitch_public: UISwitch!
    @IBOutlet weak var mTableView_invitations: UITableView!
    
    // Variables
    let mCategories = ["Video Game", "Sports", "Technology", "Outdoor Activities", "Indoor Activities", "Arts", "Music", "Auto"]
    // stored variables
    var createdEvent: [Event] = []
    var ref: DatabaseReference?
    var facebookID: [Attendees] = []
    var pulledUserId = UserDefaults.standard
    // for unique event id
    var uniqueID: DatabaseReference?
    // for user id
    var UserId: DatabaseReference?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mCategories[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        label.text = mCategories[row]
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        
        return label
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        label.text = mCategories[row]
//    }
    
    
    @IBAction func saveNewEvent(_ sender: UIButton) {
        
        storeToDatabase()
        
    }
    
    func storeToDatabase(){
        // set the firebase reference
        ref = Database.database().reference()
        
        // create an unique ID to store each event in the database
        uniqueID = ref?.child("Event").childByAutoId()
        
        
        uniqueID?.child("Title").setValue(mTextField_eventName.text)
        uniqueID?.child("Description").setValue(mTextField_description.text)
        uniqueID?.child("Location").setValue(mTextField_location.text)
        uniqueID?.child("Date").setValue(mTextField_eventDate.text)
        uniqueID?.child("Start Time").setValue(mTextField_startTime.text)
        uniqueID?.child("End Time").setValue(mTextField_endTime.text)
        uniqueID?.child("Participants").setValue(mTextField_participants.text)
        uniqueID?.child("Category").setValue(mPicker_category.description)
        uniqueID?.child("isRecurring").setValue(mSwitch_recurring.isOn)
        uniqueID?.child("isPublicOrPrivate").setValue(mSwitch_public.isOn)
        
        
        
        uniqueID?.child("uniqueID").setValue(uniqueID?.key)
        
        
        // get user uid
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        uniqueID?.child("userId").setValue(uid)
        
        createdEvent.append(Event(ieventId: uniqueID?.key, ieventName: mTextField_eventName.text, ieventStartTime: mTextField_startTime.text, ieventEndTime: mTextField_endTime.text, ieventLocation: mTextField_location.text, ieventDescription: mTextField_description.text, ieventDate: mTextField_eventDate.description, ieventParticipants: mTextField_participants.text, ieventCategory: mPicker_category.description, ieventIsReccuring: mSwitch_recurring.isOn, ieventPublicOrPrivate: mSwitch_public.isOn))
//
        //        createdEvent.append(Event(ieventTitle: eventNameField.text, ieventTime: timeTextField.text, ieventLocation: eventLocationField.text, ieventDescription: eventDescField.text, ieventDate: eventDatePicker.description, initId: uniqueID?.key, initUserId: UserId?.key))
        
        // perform segue to pass data between controllers
        performSegue(withIdentifier: "CreateToView", sender: self)
    }
    
    
    
    
    
    

    
    
    
    
    
    
    // show pop up alert
    func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Attention", message:
            "Please do not leave any fields blank.", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}
