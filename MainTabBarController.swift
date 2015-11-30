//
//  MainTabBarController.swift
//  Bar Design
//
//  Created by James Pickering on 8/9/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        for vc in viewControllers as! [UINavigationController] {
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            vc.tabBarItem.image = UIImage(named: vc.viewControllers[0] is ScanViewController ? "Barcode-50" : "Search Filled-50")?.imageWithRenderingMode(.AlwaysOriginal)

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
