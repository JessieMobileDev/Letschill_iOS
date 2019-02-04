//
//  ExploreTableTableViewController.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy on 2/3/19.
//  Copyright © 2019 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ExploreTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    // reference to the databse
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle?
    // array to use the objects and store in
    var eventList: [Event] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        GetFirebaseData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

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
                    
//                     for case let object as DataSnapshot in snapshot.children {
                    
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
                    //}
                }
                
                
                
              
            }
            
           
            // reload tableview
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIDExplore", for: indexPath) as? ExploreTableViewCell

        var event: Event = eventList[indexPath.row]
        
        cell?.title.text = event.eventName
        cell?.timeDate.text = event.eventTimeStart
        cell?.location.text = event.eventLocation
        

        return cell!
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
