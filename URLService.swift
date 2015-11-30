//
//  URLService.swift
//  Booksmart
//
//  Created by Mark Koh on 5/16/15.
//  Copyright (c) 2015 Booksmart. All rights reserved.
//

import Foundation

enum Enviroment {
    
    case Local, Dev
}

class URLService {
    
    static func buildURL(URLExtension: String) -> String {
        
        return baseURL() + URLExtension
    }
    
    static func baseURL() -> String {
        
        switch enviroment() {
            
        case .Local:
            return ""
            
        case .Dev:
            return "http://104.236.161.83/api/"
            
        default:
            return ""
        }
    }
    
    static func enviroment() -> Enviroment {
        
        return .Dev
    }
}