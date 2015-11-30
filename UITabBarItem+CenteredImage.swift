//
//  UITabBar+CenteredImage.swift
//  Bar Design
//
//  Created by James Pickering on 8/9/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

extension UITabBarItem {
    
    func tabBarItemShowingOnlyImage() -> UITabBarItem {
        
        self.imageInsets = UIEdgeInsets(top: 6,left: 0,bottom: -6,right: 0)
        
        self.setTitlePositionAdjustment(UIOffset(horizontal: 0,vertical: 30000))
        
        return self
    }
}
