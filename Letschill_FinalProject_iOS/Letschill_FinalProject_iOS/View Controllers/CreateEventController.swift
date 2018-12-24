//
//  CreateEventController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Jessica on 12/23/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit

class CreateEventController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // Outlets
    @IBOutlet weak var mPicker_category: UIPickerView!
    @IBOutlet weak var mImageView_eventImage: UIImageView!
    @IBOutlet weak var mTextField_eventName: UITextField!
    @IBOutlet weak var mTextField_location: UITextField!
    @IBOutlet weak var mTextField_eventDate: UITextField!
    @IBOutlet weak var mTextField_startTime: UITextField!
    @IBOutlet weak var mTextField_endTime: UITextField!
    @IBOutlet weak var mTextField_descritpion: UITextField!
    @IBOutlet weak var mTextField_participants: UITextField!
    @IBOutlet weak var mButton_location: UIImageView!
    @IBOutlet weak var mSwitch_recurring: UISwitch!
    @IBOutlet weak var mSwitch_public: UISwitch!
    @IBOutlet weak var mTableView_invitations: UITableView!
    
    // Variables
    let mCategories = ["Video Game", "Sports", "Technology", "Outdoor Activities", "Indoor Activities", "Arts", "Music", "Auto"]
    
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
        return mCategories.count
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
    }
    
}
