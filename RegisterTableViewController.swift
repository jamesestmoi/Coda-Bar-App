//
//  RegisterTableViewController.swift
//  Bar Design
//
//  Created by James Pickering on 9/3/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

class RegisterTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
        
        cancelButton.tintColor = UIColor.whiteColor()
        
        navigationItem.setLeftBarButtonItem(cancelButton, animated: false)

        nameLabel.text = MemberFactory.sharedFactory().name.full
        dobLabel.text = MemberFactory.sharedFactory().dob
    }
    
    func cancel() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 {
            
            MemberFactory.sharedFactory().stageContactDetails(emailField.text, phone: phoneNumberField.text)
            
            performSegueWithIdentifier("terms", sender: self)
        }
    }
}
