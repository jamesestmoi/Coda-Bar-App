//
//  MainNavigationController.swift
//  Bar Design
//
//  Created by James Pickering on 8/9/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = Theme.red
        navigationBar.borderColor = Theme.darkRed
        navigationBar.tintColor = Theme.white
        navigationBar.translucent = false
        navigationBar.bottomBorderWidth = 2
        
        let fonts = UIFont.fontNamesForFamilyName("Lato-Bold")
        
        for f in fonts {
            
            println("\(f)")
        }
        
        let font = UIFont(name: "Lato", size: 17)!
        
        navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: Theme.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return .LightContent
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
