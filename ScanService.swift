//
//  ScanService.swift
//  Bar Design
//
//  Created by James Pickering on 8/10/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit

protocol CaptuvoServiceDelegate {
    
    func decoderReady()
    func captuvoConnected()
    func captuvoDisconnected()
    func didReceiveDataFromDecoder(name: Name, dob: String, id: String, address: String, sex: String)
}

class CaptuvoService: NSObject, CaptuvoEventsProtocol {
    
    private static var _sharedService: CaptuvoService?
    static var sharedService: CaptuvoService {
        
        if _sharedService == nil {
            
            _sharedService = CaptuvoService()
        }
        
        Log("[*] Lazily made the shared service!!")
        
        return _sharedService!
    }
    
    var delegate: CaptuvoServiceDelegate?
    var isDecoderReady: Bool = false
    
    override init() {
        
        super.init()
        
        Log("[*] Initializing service")
        
        Captuvo.sharedCaptuvoDevice().addCaptuvoDelegate(self)
        Captuvo.sharedCaptuvoDevice().startPMHardware()
        
        let connectionStatus: ProtocolConnectionStatus = Captuvo.sharedCaptuvoDevice().startDecoderHardware()
    }
    
    func initializeDevice() {
        
        //Captuvo.sharedCaptuvoDevice().startPMHardware()
    }
    
    func decoderReady() {
        
        isDecoderReady = true
        
        Log("[*] Decoder ready!")
        
        delegate?.decoderReady()
    }
    
    func captuvoDisconnected() {
        
        isDecoderReady = false
        
        Log("[!] Decoder disconnected!", .Captuvo)
        
        delegate?.captuvoDisconnected()
    }
    
    func captuvoConnected() {
        
        Log("[*] Loading decoder...", .Captuvo)
        
        delegate?.captuvoConnected()
        
        let connectionStatus: ProtocolConnectionStatus = Captuvo.sharedCaptuvoDevice().startDecoderHardware()
    }
    
    func startScanning() {
        
        Captuvo.sharedCaptuvoDevice().startDecoderScanning()
    }
    
    func stopScanning() {
        
        Captuvo.sharedCaptuvoDevice().stopDecoderScanning()
    }
    
    func decoderDataReceived(data: String!) {
        
        let pb = UIPasteboard.generalPasteboard()
        pb.string = data
        
        let dataArr = data.componentsSeparatedByString("\n")
        
        //AlertService.showAlertWithTitle("Testing", andMessage: "shit works up to here")
        
        if isValidData(dataArr) {
            let (name, dob, id, address, sex) = parseData(dataArr)
            
            if id != nil && dob != nil && sex != nil {
                
                delegate?.didReceiveDataFromDecoder(name, dob: dob!, id: id!, address: address, sex: sex!)
            }
            else {
                
                AlertService.showAlertWithTitle("Scanning Error", andMessage: "Some of the attributes of the ID could not be parsed. Please try again.")
            }
        }
        else {
            
            AlertService.showAlertWithTitle("Invalid Barcode", andMessage: "Make sure you're scanning the right barcode on the ID.")
        }
    }
    
    func parseData(dataArr: [String]) -> (name: Name, dob: String?, id: String?, address: String, sex: String?){
        
        var name: Name!
        var dob: String?
        var id: String?
        var address = ""
        var sex: String?
        
        var address2 = ""
        var city = ""
        var state = ""
        var zip = ""
        
        if isDriversLiscense(dataArr)  {
            
            //AlertService.showAlertWithTitle("is drivers liscense", andMessage: nil)
            
            for keyAndValue: NSString in dataArr {
                
                if keyAndValue.containsString("DAG") {
                    
                    address2 = keyAndValue.stringByReplacingOccurrencesOfString("DAG", withString: "")
                    
                    continue
                }
                if keyAndValue.containsString("DAI") {
                    
                    city = keyAndValue.stringByReplacingOccurrencesOfString("DAI", withString: "")
                    
                    continue
                }
                if keyAndValue.containsString("DAJ") {
                    
                    state = keyAndValue.stringByReplacingOccurrencesOfString("DAJ", withString: "")
                    
                    continue
                }
                if keyAndValue.containsString("DBC") {
                    
                    sex = keyAndValue.stringByReplacingOccurrencesOfString("DBC", withString: "")
                    
                    continue
                }
                if keyAndValue.containsString("DAK") {
                    
                    zip = keyAndValue.stringByReplacingOccurrencesOfString("DAK", withString: "")
                    
                    continue
                }
                if keyAndValue.containsString("DAA") {
                    
                    //AlertService.showAlertWithTitle("Finna parse full name", andMessage: nil)
                    
                    let fullname = keyAndValue.stringByReplacingOccurrencesOfString("DAA", withString: "")
                    
                    //AlertService.showAlertWithTitle("Fullname for drivers liscense", andMessage: fullname)
                    
                    name = Name(fullname)
                    
                    continue
                }
                if keyAndValue.containsString("DBB") {
                    
                    let unformattedDOB = keyAndValue.stringByReplacingOccurrencesOfString("DBB", withString: "")
                    
                    let formatter = NSDateFormatter()
                    
                    formatter.dateFormat = "yyyyMMdd"
                    
                    if let dateDOB = formatter.dateFromString(unformattedDOB) {
                        
                        formatter.dateFormat = "yyyy-MM-dd"
                        
                        dob = formatter.stringFromDate(dateDOB)
                    }
                }
                if keyAndValue.containsString("AAMVA") && keyAndValue.containsString("AAMVA") {
                    
                    let scanner = NSScanner(string: keyAndValue as String)
                    var scanned: NSString?
                    
                    if scanner.scanUpToString("AAMVA", intoString:nil) {
                        
                        scanner.scanString("AAMVA", intoString:nil)
                        
                        if scanner.scanUpToString("DL", intoString: &scanned) {
                            
                            id = scanned as? String
                        }
                    }
                    
                    continue
                }
            }
        }
        else {
            
            var firstname = String()
            var lastname = String()
            
            for keyAndValue: NSString in dataArr {
                
                if keyAndValue.containsString("DAG") {
                    
                    address2 = keyAndValue.stringByReplacingOccurrencesOfString("DAG", withString: "")
                    
                    continue
                }
                if keyAndValue.containsString("DAI") {
                    
                    city = keyAndValue.stringByReplacingOccurrencesOfString("DAI", withString: "")
                    
                    continue
                }
                if keyAndValue.containsString("DAJ") {
                    
                    state = keyAndValue.stringByReplacingOccurrencesOfString("DAJ", withString: "")
                    
                    continue
                }
                if keyAndValue.containsString("DBC") {
                    
                    if keyAndValue.stringByReplacingOccurrencesOfString("DBC", withString: "") == "1" {
                        sex = "M"
                    }
                    else {
                        sex = "F"
                    }
                    
                    continue
                }
                if keyAndValue.containsString("DAK") {
                    
                    zip = keyAndValue.stringByReplacingOccurrencesOfString("DAK", withString: "")
                    
                    continue
                }
                
                if keyAndValue.containsString("DAC") {
                    
                    firstname = keyAndValue.stringByReplacingOccurrencesOfString("DAC", withString: "")
                    
                    //AlertService.showAlertWithTitle("First name of other id", andMessage: firstname)
                    
                    continue
                }
                if keyAndValue.containsString("DCS") {
                    
                    lastname = keyAndValue.stringByReplacingOccurrencesOfString("DCS", withString: "")
                    
                    //AlertService.showAlertWithTitle("Last name of other id", andMessage: lastname)
                    
                    continue
                }
                if keyAndValue.containsString("DBB") {
                    
                    let unformattedDOB = keyAndValue.stringByReplacingOccurrencesOfString("DBB", withString: "")
                    
                    let formatter = NSDateFormatter()
                    
                    formatter.dateFormat = "MMddyyyy"
                    
                    if let dateDOB = formatter.dateFromString(unformattedDOB) {
                        
                        formatter.dateFormat = "yyyy-MM-dd"
                        
                        dob = formatter.stringFromDate(dateDOB)
                    }
                }
                if keyAndValue.containsString("DAQ") {
                    
                    id = keyAndValue.stringByReplacingOccurrencesOfString("DAQ", withString: "")
                    
                    continue
                }
            }
            
            name = Name(firstname, lastname)
        }
        address = address2.lowercaseString.capitalizedString + " " + city + " " + state + " " + zip
        
        if let i = id {
            id = name.full.stringByReplacingOccurrencesOfString(" ", withString: "") + i
        }
        
        return (name, dob, id, address, sex)
    }
    
    func isDriversLiscense(dataArr: [String]) -> Bool {
        
        /*(Log("Data Arr: \(dataArr.count): \(dataArr)")
        
        return true*/
        
        let data = dataArr[1] as NSString
        
        return data.containsString("AAMVA") && data.containsString("DL")
    }
    
    func isValidData(dataArr: [String]) -> Bool {
        
        if dataArr.count < 2 { return false }
        
        for data in dataArr {
            
            let d = data as NSString
            
            if (d.containsString("AAMVA") && d.containsString("DL")) || d.containsString("ANSI") {
                
                return true
            }
        }
        
        return false
    }
}
