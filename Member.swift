//
//  Member.swift
//  Bar Design
//
//  Created by James Pickering on 9/8/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit
import SwiftyJSON

class Member: Objectable {
   
    private(set) var name: Name!
    internal var id: Int
    private(set) var uniqueId: String!
    private(set) var dob: String!
    private(set) var sex: String!
    private(set) var address: String!
    
    private(set) var email: String!
    private(set) var phone: String!
    
    init(name: Name, uniqueId: String, dob: String, sex: String, address: String, email: String, phone: String) {
        
        self.name = name
        self.uniqueId = uniqueId
        self.dob = dob
        self.sex = sex
        self.address = address
        self.email = email
        self.phone = phone
        self.id = 0
    }
    
    required init(json: JSON) {
        
        name = Name(json["first_name"].stringValue, json["last_name"].stringValue)
        uniqueId = json["unique_id"].stringValue
        dob = json["dob"].stringValue
        sex = json["sex"].stringValue
        address = json["address"].stringValue
        id = json["id"].intValue
        
        if let e = json["email"].string {
            email = e
        }
        else {
            email = ""
        }
        
        if let p = json["phone"].string {
            phone = p
        }
        else {
            phone = ""
        }
    }
    
    func JSON_encode() -> JSON {
        
        return JSON([])
    }
}
