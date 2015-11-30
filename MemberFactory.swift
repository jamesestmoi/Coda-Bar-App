//
//  MemberFactory.swift
//  Bar Design
//
//  Created by James Pickering on 9/3/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class Name {
    
    var first: String
    var last: String
    
    var full: String {
        
        return first + " " + last
    }
    
    init(_ first: String, _ last: String) {
        
        self.first = first.lowercaseString.capitalizedString
        self.last = last.lowercaseString.capitalizedString
    }
    
    convenience init(_ full: String) {
        
        var arr = full.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        while true {
            
            if let l = arr.last {
                if arr.last!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" {
                    
                    break
                }
                else {
                    
                    arr.removeLast()
                }
            }
            else {
                
                break
            }
        }
        
        if arr.count > 1 {
            
            self.init(arr.first!, arr.last!)
        }
        else if arr.count == 1 {
            
            self.init(arr.first!, "")
        }
        else {
            
            self.init("", "")
        }
    }
}

class MemberFactory: NSObject {
    
    private static let _sharedFactory = MemberFactory()
    static func sharedFactory() -> MemberFactory {
        
        return _sharedFactory
    }
    
    func startBuildingNewMember() {
        
        name = Name("", "")
        id = ""
        dob = ""
        sex = ""
        address = ""
        email = ""
        phone = ""
    }
    
    func stageScannedDetails(name: Name, id: String, dob: String, sex: String, address: String) {
        
        self.name = name
        self.id = id
        self.dob = dob
        self.sex = sex
        self.address = address
    }
    
    func stageContactDetails(email: String, phone: String) {
        
        self.email = email
        self.phone = phone
    }
    
    func stageSignature(signature: UIImage) {
        
        self.signature = signature
    }
    
    func finishBuildingNewMember() {
        
        MemberService.registerMember(name, id: id, email: email, phone: phone, dob: dob, sex: sex, address: address, signature: signature)
    }
    
    private(set) var name: Name!
    private(set) var id: String!
    private(set) var dob: String!
    private(set) var sex: String!
    private(set) var address: String!
    
    private(set) var email: String!
    private(set) var phone: String!
    
    private(set) var signature: UIImage!
}
