//
//  AuthService.swift
//  Bar Design
//
//  Created by James Pickering on 8/8/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class AuthService: BaseNetworkService {
    
    static func login(email: String, password: String, completion: (Bool) -> ()) {
        
        BaseNetworkService.post("login", parameters: ["email": email, "password": password], success: { (response) -> () in
            
            println("Response: \(response)")
            
            if response["user"].null == nil {
                
                self.saveCredentials(email, password: password)
                
                let userJSON = response["user"]
                let user = User(json: userJSON)
                
                let membersJSON = response["members"]
                
                for memberJSON in membersJSON.arrayValue {
                    
                    let member = Member(json: memberJSON)
                    
                    user.members.append(member)
                }
                
                User.setCurrentUser(user)
                
                completion(true)
                return
            }
            
            completion(false)
            return
            
        }) { (error) -> () in
            
        }
    }
    
    static func credentials() -> (email: String, password: String)? {
        
        if let email = NSUserDefaults.standardUserDefaults().objectForKey("email") as? String {
            if let password = NSUserDefaults.standardUserDefaults().objectForKey("password") as? String {
                
                return (email: email, password: password)
            }
        }
        
        return nil
    }
    
    private static func saveCredentials(email: String, password: String) {
        
        NSUserDefaults.standardUserDefaults().setObject(email, forKey: "email")
        NSUserDefaults.standardUserDefaults().setObject(password, forKey: "password")
    }
}
