//
//  SignatureViewController.swift
//  Bar Design
//
//  Created by James Pickering on 9/9/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController {
    
    @IBOutlet weak var sigView: SignatureView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var finishButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        title = "Signature"
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func finish(sender: AnyObject) {
        
        let image = sigView.finalImage()
        
        MemberFactory.sharedFactory().stageSignature(image)
        MemberFactory.sharedFactory().finishBuildingNewMember()
        
        dismissViewControllerAnimated(true, completion: nil)
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
