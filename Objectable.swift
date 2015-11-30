//
//  Databaseable.swift
//  Bar Design
//
//  Created by James Pickering on 8/10/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol Objectable {
    
    var id: Int { get set }
    func JSON_encode() -> JSON
    init(json: JSON)
}
