//
//  ScanViewController.swift
//  Bar Design
//
//  Created by James Pickering on 8/9/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit
import MRoundedButton
import PureLayout

class ScanViewController: UIViewController, CaptuvoServiceDelegate {
    
    var scanButton: MRoundedButton!
    var scanSuccessful = false
    var name: String!
    var dob: String!
    var id: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CaptuvoService.sharedService.delegate = self
        
        scanButton = MRoundedButton(frame: CGRectMake(0, 0, 200, 200), buttonStyle: MRoundedButtonStyle.Default)
        
        scanButton.textLabel.text = "LOADING..."
        scanButton.cornerRadius = 100
        scanButton.contentColor = Theme.white
        scanButton.contentAnimationColor = Theme.white
        scanButton.foregroundColor = Theme.red
        scanButton.foregroundAnimationColor = Theme.darkRed
        
        scanButton.enabled = false
        
        scanButton.layer.shadowColor = Theme.darkRed.CGColor
        scanButton.layer.shadowOffset = CGSizeMake(0, 4)
        scanButton.layer.shadowRadius = 0
        
        view.addSubview(scanButton)
        
        scanButton.autoCenterInSuperviewMargins()
        scanButton.autoSetDimension(.Width, toSize: 200)
        scanButton.autoSetDimension(.Height, toSize: 200)
        scanButton.addTarget(self, action: "startScanning", forControlEvents: .TouchDown)
        scanButton.addTarget(self, action: "stopScanning", forControlEvents: .TouchUpOutside)
        scanButton.addTarget(self, action: "stopScanning", forControlEvents: .TouchUpInside)
        
        if CaptuvoService.sharedService.isDecoderReady == true {
            
            decoderReady()
        }
    }
    
    func startScanning() {
        
        scanButton.textLabel.text = "SCANNING"
        
        CaptuvoService.sharedService.startScanning()
    }
    
    func stopScanning() {
        
        CaptuvoService.sharedService.stopScanning()
        
        scanButton.textLabel.text = "SCAN"
    }
    
    func showMemberIsValid(name: Name) {
        
        let alertVC = UIAlertController(title: "Verified", message: "\(name.full) is a member.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertVC.addAction(alertAction)
        
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func showMemberIsNotValid(name: Name, dob: String, id: String, address: String, sex: String) {
        
        let alertVC = UIAlertController(title: "Membership Not Found", message: "\(name.full) is not a member.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let registerAction = UIAlertAction(title: "Register", style: .Default) { (action) -> Void in
            
            MemberFactory.sharedFactory().startBuildingNewMember()
            MemberFactory.sharedFactory().stageScannedDetails(name, id: id, dob: dob, sex: sex, address: address)
            
            self.performSegueWithIdentifier("newUser", sender: self)
        }
        
        alertVC.addAction(registerAction)
        
        let alertAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        alertVC.addAction(alertAction)
        
        presentViewController(alertVC, animated: true, completion: nil)
    }

    func decoderReady() {
        
        println("Decoder ready")
        scanButton.enabled = true
        scanButton.textLabel.text = "SCAN"
    }
    
    func captuvoConnected() {
        
        println("Captuvo Connected")
    }
    
    func captuvoDisconnected() {
        
        println("Decoder disconnected")
        scanButton.enabled = false
    }
    
    func didReceiveDataFromDecoder(name: Name, dob: String, id: String, address: String, sex: String) {
        
        stopScanning()
        
        scanButton.enabled = false
        scanButton.enabled = true
        
        MemberService.validateMember(id, completion: { (isValid) -> () in
            
            if isValid {
                
                self.showMemberIsValid(name)
            }
            else {
                
                self.showMemberIsNotValid(name, dob: dob, id: id, address: address, sex: sex)
            }
        })
    }
}
