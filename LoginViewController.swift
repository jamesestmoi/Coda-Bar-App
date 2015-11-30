//
//  ViewController.swift
//  Bar Design
//
//  Created by James Pickering on 8/8/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit
import QuartzCore

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var placeholderLogoView: UIView!
    
    var emptyBorder: (email: CALayer, password: CALayer) = (email: CALayer(), password: CALayer())
    var filledBorder: (email: CALayer?, password: CALayer?)
    
    @IBOutlet var loginButton: UIButton!
    
    var keyboardHeight: CGFloat = 0.0
    
    @IBOutlet var topSection: UIView!

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var dismissKeyboardTapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dismissKeyboardTapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        emailField.tintColor = Theme.red
        passwordField.tintColor = Theme.red
        
        emailField.delegate = self
        passwordField.delegate = self
        
        var str = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName:Theme.placeholder])
        
        emailField.attributedPlaceholder = str
        
        str = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName:Theme.placeholder])
        
        passwordField.attributedPlaceholder = str
        
        loginButton.addTarget(self, action: "loginButtonTapped", forControlEvents: .TouchUpInside)
        loginButton.addTarget(self, action: "loginButtonTouchDown", forControlEvents: .TouchDown)
        loginButton.addTarget(self, action: "loginButtonTouchUp", forControlEvents: .TouchUpOutside)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        setNeedsStatusBarAppearanceUpdate()
        
        if let creds = AuthService.credentials() {
            
            emailField.text = creds.email
            passwordField.text = creds.password
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    func dismissKeyboard() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    func keyboardWillShow(sender: NSNotification) {
        
        if let size = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
            
            keyboardHeight = size.height
            
            let duration = sender.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
            
            self.view.layoutIfNeeded()
            
            self.topConstraint.constant = self.keyboardHeight
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                
            })
            
            self.view.frame.origin.y = -keyboardHeight
            
        }
    }
    func keyboardWillHide(sender: NSNotification) {
        
        self.view.frame.origin.y += keyboardHeight
        topConstraint.constant = 0
    }

    func loginButtonTapped() {
        
        if loginButton.titleForState(.Normal) != "" && validateForm() == true {

            emailField.resignFirstResponder()
            passwordField.resignFirstResponder()
            
            loginButtonTouchUp()
        
            loginButton.setTitle("", forState: .Normal)
            loginButton.enabled = false
            
            let ind = ActivityIndicator()
            
            ind.frame.origin.x = loginButton.layer.frame.width / 2 - 6.5
            ind.frame.origin.y = loginButton.layer.frame.height / 2 - 6.5
            
            loginButton.layer.addSublayer(ind)
            
            AuthService.login(emailField.text, password: passwordField.text, completion: { (success) -> () in
                
                self.loginButton.setTitle("GO →", forState: .Normal)
                self.loginButton.enabled = true
                
                ind.removeFromSuperlayer()
                
                if success == true {
                    
                    self.login()
                    
                }
                else {
                    
                    self.showAlert("Login Unsuccessful", withMessage: "Either your email or password is incorrect. Please try again")
                }
            })
        }
    }
    
    func login() {
        
        let tabBarViewController = self.storyboard!.instantiateViewControllerWithIdentifier("tabs") as! UITabBarController
        
        presentViewController(tabBarViewController, animated: true, completion: nil)
    }
    
    func validateForm() -> Bool {
        
        if emailField.text == "" {
            
            showAlert("Before You Log In", withMessage: "Please enter your email to log in")
            return false
        }
        
        if passwordField.text == "" {
            
            showAlert("Before You Log In", withMessage: "Please enter your password to log in")
            return false
        }
        
        return true
    }
    
    func showAlert(title: String, withMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okayAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(okayAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func loginButtonTouchDown() {
        
        loginButton.bottomBorderWidth = 0
    }
    
    func loginButtonTouchUp() {
        
        loginButton.bottomBorderWidth = 5
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        view.removeGestureRecognizer(dismissKeyboardTapGesture)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        view.addGestureRecognizer(dismissKeyboardTapGesture)
    }
}

