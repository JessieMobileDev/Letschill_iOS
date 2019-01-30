//
//  Event.swift
//  Letschill_FinalProject_iOS
//
//  Created by Prajwal Ramamurthy on 12/4/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import Foundation

class Event{
    var eventId : String?
    var eventName: String?
    var eventTimeStart: String?
    var eventTimeFinish: String?
    var eventLocation: String?
    var eventDescription: String?
    var eventDate: String?
    var participants : String?
    var category : String?
    var isReccuring : Bool?
    var publicOrPrivate : Bool?
    var host : String?
    var url : String?
    var latitude : Double?
    var longitude : Double?
    var joinedPeople : Int?
    var host_uids : String?
    var mJoinedPeopleIdsList : [String]?
    
    init(ieventId: String?, ieventName: String?, ieventStartTime: String?, ieventEndTime: String?, ieventLocation: String?, ieventDescription: String?, ieventDate: String?,ieventParticipants: String?, ieventCategory: String?, ieventIsReccuring: Bool?, ieventPublicOrPrivate: Bool?) {
        self.eventId = ieventId
        self.eventName = ieventName
        self.eventTimeStart = ieventStartTime
        self.eventTimeFinish = ieventEndTime
        self.eventLocation = ieventLocation
        self.eventDescription = ieventDescription
        self.eventDate = ieventDate
        self.participants = ieventParticipants
        self.category = ieventCategory
        self.isReccuring = ieventIsReccuring
        self.publicOrPrivate = ieventPublicOrPrivate
        
    }
    
    //    init(ieventId: String?, ieventName: String?, ieventStartTime: String?, ieventEndTime: String?, ieventLocation: String?, ieventDescription: String?, ieventDate: String?,ieventParticipants: String?, ieventCategory: String?, ieventIsReccuring: Bool?, ieventPublicOrPrivate: Bool?, ieventHost: String?, ieventUrl: String?, ieventLatitude: Double?, ieventLongitude: Double?, ieventJoined: Int?, iHostId: String?, iJoinedPplList: [String]?) {
    //        self.eventId = ieventId
    //        self.eventName = ieventName
    //        self.eventTimeStart = ieventStartTime
    //        self.eventTimeFinish = ieventEndTime
    //        self.eventLocation = ieventLocation
    //        self.eventDescription = ieventDescription
    //        self.eventDate = ieventDate
    //        self.userId = initUserId
    //
    //    }
    
    
    //    override init(){
    //        eventName = " "
    //        eventId = ""
    //        eventDate = ""
    //        eventTimeStart = ""
    //        eventTimeFinish = ""
    //        eventDescription = ""
    //        eventLocation = ""
    //        eventId = ""
    //        participants = ""
    //        category = ""
    //        isReccuring = true
    //        publicOrPrivate = true
    //        host = ""
    //        url = ""
    //        latitude = 0.0
    //        longitude = 0.0
    //        joinedPeople = 0
    //        host_uids = ""
    //        mJoinedPeopleIdsList = [""]
    //
    //    }
    //
    
    
    //    init(ieventName: String?, ieventTime: String?, ieventLocation: String?, ieventDescription: String?, ieventDate: String?, initId: String?) {
    //        self.eventDate = ieventDate
    //        self.eventName = ieventName
    //        self.eventTime = ieventTime
    //        self.eventLocation = ieventLocation
    //        self.eventDescription = ieventDescription
    //        self.id = initId
    //
    //    }
    //
    
}
