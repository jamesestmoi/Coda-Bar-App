//
//  SignatureView.swift
//  Bar Design
//
//  Created by James Pickering on 9/8/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

import UIKit
import QuartzCore

class SignatureView: UIView {
    
    var path = UIBezierPath()
    var incrementalImage: UIImage!
    var pts = [CGPoint](count: 5, repeatedValue: CGPointZero)
    var ctr: UInt = 0
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        multipleTouchEnabled = false
        backgroundColor = UIColor.whiteColor()
        
        path.lineWidth = 2
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        multipleTouchEnabled = false
        backgroundColor = UIColor.whiteColor()
        
        path.lineWidth = 2
    }
    
    override func drawRect(rect: CGRect) {
        
        if let i = incrementalImage {
            i.drawInRect(rect)
        }
        
        path.stroke()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        ctr = 0
        
        let touch = touches.first as! UITouch
        pts[0] = touch.locationInView(self)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touch = touches.first as! UITouch
        let p = touch.locationInView(self)
        
        ctr += 1
        
        pts[Int(ctr)] = p
        
        if ctr == 4 {
            
            pts[3] = CGPointMake((pts[2].x + pts[4].x) / 2.0, (pts[2].y + pts[4].y) / 2.0)
            
            path.moveToPoint(pts[0])
            path.addCurveToPoint(pts[3], controlPoint1: pts[1], controlPoint2: pts[2])
            
            setNeedsDisplay()
            
            pts[0] = pts[3]
            pts[1] = pts[4]
            
            ctr = 1
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        drawBitmap()
        setNeedsDisplay()
        
        path.removeAllPoints()
        
        ctr = 0
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        
        touchesEnded(touches, withEvent: event)
    }
    
    func drawBitmap() {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0)
        
        if incrementalImage == nil {
            
            let rectpath = UIBezierPath(rect: bounds)
            
            UIColor.whiteColor().setFill()
            
            rectpath.fill()
        }
        
        if let i = incrementalImage {
            
           i.drawAtPoint(CGPointZero)
        }
        
        UIColor.blackColor().setStroke()
        path.stroke()
        
        incrementalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    func finalImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, 0.0);
        
        layer.renderInContext(UIGraphicsGetCurrentContext())
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
    
        UIGraphicsEndImageContext();
    
        return img;
    }
}
