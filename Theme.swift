//
//  Theme.swift
//  Bar Design
//
//  Created by James Pickering on 8/8/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class Theme: NSObject {
   
    static var extraLightRed = UIColor(red: 1, green: 205/255.0, blue: 210/255.0, alpha: 1)
    static var red = UIColor(red: 244/255.0, green: 67/255.0, blue: 54/255.0, alpha: 1)
    static var darkRed = UIColor(red: 198/255.0, green: 40/255.0, blue: 40/255.0, alpha: 1)
    static var white = UIColor.whiteColor()
    static var placeholder = UIColor(white: 1, alpha: 0.7)
    static var black = UIColor(red: 38/255.0, green: 50/255.0, blue: 56/255.0, alpha: 1)
    static var grey = UIColor(red: 48/255.0, green: 60/255.0, blue: 56/255.0, alpha: 1)
    static var darkGrey = UIColor(red: 38/255.0, green: 50/255.0, blue: 56/255.0, alpha: 1)
}

extension UIColor {
    
    class func _blackColor() -> UIColor {
        return Theme.black
    }
}