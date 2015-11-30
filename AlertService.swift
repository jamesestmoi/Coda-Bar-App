//
//  AlertService.swift
//  Bar Design
//
//  Created by James Pickering on 9/8/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class AlertService: NSObject {
   
    static func showAlertWithTitle(title: String?, andMessage message: String?) {
        
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        vc.addAction(action)
        
        UIApplication.sharedApplication().keyWindow!.rootViewController?.presentedViewController?.presentViewController(vc, animated: true, completion: nil)
    }
}
