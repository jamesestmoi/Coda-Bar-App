//
//  Personable.swift
//  Bar Design
//
//  Created by James Pickering on 8/10/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

protocol Personable {
   
    var name: String { get set }
    var email: String? { get set }
    var phone: String? { get set }
}
