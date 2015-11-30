//
//  BaseNetworkService.swift
//  Booksmart
//
//  Created by Mark Koh on 5/16/15.
//  Copyright (c) 2015 Booksmart. All rights reserved.
//

import Alamofire
import SwiftyJSON

class BaseNetworkService {
    
    static func post(url: String, parameters: [String: AnyObject]?, success: (response: JSON) -> (), failure: (error: NSError) -> ()) {
        
        let url = URLService.buildURL(url)
        
        log("[*] POST: \(url)")
        
        request(url, parameters: parameters, methodString: "POST", success: success, failure: failure)
    }
    
    static func get(url: String, parameters: [String: AnyObject]?, success: (response: JSON) -> (), failure: (error: NSError) -> ()) {
        
        let url = URLService.buildURL(url)
        
        log("[*] GET: \(url)")
        
        request(url, parameters: parameters, methodString: "GET", success: success, failure: failure)
    }
    
    private static func request(url: String, parameters: [String: AnyObject]?, methodString: String, success: (response: JSON) -> (), failure: (error: NSError) -> ()) {
        
        let parameters = parameters == nil ? [String: AnyObject]() : parameters!
        let method = Method(rawValue: methodString)!
        
        Alamofire.request(method, url, parameters: parameters).response { (req, res, data, error) -> Void in
            
            if error != nil {
                
                AlertService.showAlertWithTitle("Server Error", andMessage: error!.localizedDescription)
                failure(error: error!)
                return
            }
            
            var serializationError: NSError?
            
            let data: AnyObject? = NSJSONSerialization.JSONObjectWithData(data! as NSData, options: NSJSONReadingOptions.AllowFragments, error: &serializationError)
            
            if serializationError != nil {
                failure(error: serializationError!)
                return
            }
            
            if data == nil {
                Log("[!] No data returned for call \"\(method): \(url)\"", .Error)
            }
            
            let json = JSON(data!)
            
            success(response: json)
        }
        
    }
    
    static func log(message: String) {
        Log(message, .Networking)
    }
}