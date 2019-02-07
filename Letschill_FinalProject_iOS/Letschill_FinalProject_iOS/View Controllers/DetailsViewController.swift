//
//  DetailsViewController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy on 2/3/19.
//  Copyright © 2019 Prajwal Ramamurthy. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class DetailsViewController: UIViewController{
    
    @IBOutlet weak var dEventNameField: UILabel!
    @IBOutlet weak var dDateTimeField: UILabel!
    @IBOutlet weak var dLocField: UILabel!
    @IBOutlet weak var dHostField: UILabel!
    @IBOutlet weak var dDescField: UILabel!
    @IBOutlet weak var dPartField: UILabel!
    @IBOutlet weak var dCategoryField: UILabel!
    
    // reference to the databse
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle?
    // array to use the objects and store in
    var eventList: [Event] = []
    var event:Event?
    
    override func viewDidLoad() {
        //code
        //GetFirebaseData()
        if (event != nil) {
            self.dEventNameField.text = event?.eventName
            self.dDateTimeField.text = event?.eventTimeStart
            self.dLocField.text = event?.eventLocation
            // self.dHostField.text =
            self.dDescField.text = event?.eventDescription
            self.dPartField.text = event?.participants
            self.dCategoryField.text = event?.category
        }
    }
    
    
    @IBAction func JoinEventButton(_ sender: Any) {
           // performSegue(withIdentifier: "detailsToListView", sender: self)
        showAlertCongrats(self)
        
    }
    
    func loadMyData()
    {
        
    }
    
    // custom function to fetch data
    func GetFirebaseData()
    {
        ref = Database.database().reference().child("Events") //setting my reference to start inside of my users node
        ref.observe(.childAdded, with: { (snapshot) in
            
            //print(snapshot.value)
            // Get user value and set it to the currentPerson object that i have set
            
            for case let month as DataSnapshot in snapshot.children {
                //print(rest.value)
                
                for case let date as DataSnapshot in month.children {
                    
            
                    let event = date.value as? NSDictionary
                    
                    //print(snapshot.value)
                    let eventId = event?["mEventId"] as? String ?? ""
                    let title = event?["mEventName"] as? String ?? ""
                    let date = event?["mEventDate"] as? String ?? ""
                    let time = event?["mEventTimeStart"] as? String ?? ""
                    let location = event?["mEventLocation"] as? String ?? ""
                    let part = event?["mParticipants"] as? String ?? ""
                    let cate = event?["mCategory"] as? String ?? ""
                    let desc = event?["mDescription"] as? String ?? ""
                    
                    // add it to our data model
                    self.eventList.append(Event(ieventId: eventId, ieventName: title, ieventStartTime: time, ieventEndTime: time, ieventLocation: location, ieventDescription: desc, ieventDate: date, ieventParticipants: part, ieventCategory: cate, ieventIsReccuring: true, ieventPublicOrPrivate: true))
                    
                    // assign it to labels to update UI
                    
                    
                    
                }
       
            }

            DispatchQueue.main.async {
      
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    func showAlertCongrats(_ sender: Any) {
        let alertController = UIAlertController(title: "Congrats!", message:
            "You have joined the event and the host will be notified Thank You!", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    
    }
}
