//
//  User.swift
//  Bar Design
//
//  Created by James Pickering on 8/10/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: Objectable {
    
    private static var _currentUser: User?
    static func currentUser() -> User! {
        
        if _currentUser == nil {
            Log("[!] The current user isn't initialized! Danger!!!", .Error)
        }
        return _currentUser
    }
    
    static func setCurrentUser(user: User) {
        
        _currentUser = user
    }
   
    var id: Int
    var name: String
    var email: String
    var members = [Member]()
    
    init(id: Int, name: String, email: String) {
        
        self.id = id
        self.name = name
        self.email = email
    }
    
    required init(json: JSON) {
        
        id = json["id"].intValue
        name = json["name"].stringValue
        email = json["email"].stringValue
    }
    
    func JSON_encode() -> JSON {
        
        return JSON([])
    }
}
