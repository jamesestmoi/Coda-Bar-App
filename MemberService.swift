//
//  MemberService.swift
//  Bar Design
//
//  Created by James Pickering on 9/3/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class MemberService: BaseNetworkService {
   
    static func validateMember(memberId: String, completion: (Bool) -> ()) {
        
        Log("[*] Validating member")
        
        get("scan", parameters: ["id_number": memberId], success: { (response) -> () in
            
            if response["success"].intValue == 0 {
                
                completion(false)
            }
            else {
                
                completion(true)
            }
            
        }) { (error) -> () in
            
            
        }
    }
    
    static func registerMember(name: Name, id: String, email: String, phone: String, dob: String, sex: String, address: String, signature: UIImage) {
        
        let member = Member(name: name, uniqueId: id, dob: dob, sex: sex, address: address, email: email, phone: phone)
        
        User.currentUser().members.append(member)
        
        post("member/register", parameters: ["first_name": name.first, "last_name": name.last, "middle_name": "", "phone": phone, "dob": dob, "id_number": id, "sex": sex, "address": address, "subscribed": "1"], success: { (response) -> () in
            
            Log("YEET")
        }) { (error) -> () in
            
            Log("FUCK")
        }
    }
}
