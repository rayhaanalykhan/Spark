//
//  ClassRoosterDM.swift
//  Spark
//
//  Created by rayhaanalykhan on 25/06/2024.
//

import Foundation

// MARK: - RosterDM
struct RosterDM: Codable {
    
    let classRosterAttendeeID: Int?
    let checkOutToo: Bool?
    let classRosterID: Int?
    let classRosterName: String?
    let classDateTime: String?
    let classStartTime: String?
    let classEndTime: String?
    let registeredContacts: [RegisteredContactDM]?
}

// MARK: - RegisteredContactDM
struct RegisteredContactDM: Codable {
    
   let name: String?
   let image: String?
   let contactID: Int?
   let contactType: String? // String? -> ContactType?

   enum CodingKeys: String, CodingKey {
       case name, image
       case contactID = "contactId"
       case contactType
   }
}

//enum ContactType: String, Codable {
//   case activeMember = "Active Member"
//   case afterSchooler = "After Schooler"
//   case fitness = "Fitness"
//   case formerMember = "Former Member"
//   case prospect = "Prospect"
//}

