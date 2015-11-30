//
//  LoggerService.swift
//  Booksmart
//
//  Created by Mark Koh on 7/7/15.
//  Copyright (c) 2015 Booksmart. All rights reserved.
//
//  Usage: Logger("This is an authentication message", log.auth)

// If you have a new logger category, throw it in here

import UIKit

class Log {
    
    enum Category {
        case General, Networking, Auth, CoreData, Error, Captuvo
    }
    
    private let logAll: Bool = true
    
    // Only log messages that fall under these categories
    private let include: [Category] = [
        .General,
        .Networking,
        .Auth,
        .Captuvo,
        .Error
    ]
    
    init(_ message: String, _ category: Category = .General) {
        if logAll || contains(include, category) {
            println(message)
            
            let label = UILabel(frame: CGRectMake(0, 20, 320, 20))
            label.backgroundColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(12)
            
            label.text = message
            
            //UIApplication.sharedApplication().delegate!.window!?.addSubview(label)
        }
    }
}