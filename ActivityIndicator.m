//
//  ActivityIndicator.m
//  Bar Design
//
//  Created by James Pickering on 8/8/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

#import "ActivityIndicator.h"

// Default values
#define kDefaultNumberOfSpinnerMarkers 60
#define kDefaultSpread 11
#define kDefaultColor ([UIColor whiteColor])
#define kDefaultThickness 8.0
#define kDefaultLength 25.0
#define kDefaultSpeed 0.5

// HUD defaults
#define kDefaultHUDSide 15
#define kDefaultHUDColor ([UIColor colorWithWhite:0.0 alpha:0.0])

#define kMarkerAnimationKey @"MarkerAnimationKey"

@implementation ActivityIndicator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CALayer * marker = [CALayer layer];
        [marker setBounds:CGRectMake(0, 0, kDefaultThickness, 1)];
        [marker setCornerRadius:kDefaultThickness*0.5];
        [marker setBackgroundColor:[kDefaultColor CGColor]];
        [marker setPosition:CGPointMake(kDefaultHUDSide*0.5, kDefaultHUDSide*0.5+kDefaultSpread)];
        
        [self setBounds:CGRectMake(0, 0, kDefaultHUDSide, kDefaultHUDSide)];
        [self setCornerRadius:10.0];
        [self setBackgroundColor:[kDefaultHUDColor CGColor]];
        [self setPosition:CGPointMake(CGRectGetMidX([self frame]),
                                                   CGRectGetMidY([self frame]))];
        CGFloat angle = (2.0*M_PI)/(kDefaultNumberOfSpinnerMarkers);
        CATransform3D instanceRotation = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0);
        [self setInstanceCount:kDefaultNumberOfSpinnerMarkers];
        [self setInstanceTransform:instanceRotation];
        
        [self addSublayer:marker];
        
        [marker setOpacity:0.0];
        CABasicAnimation * fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [fade setFromValue:[NSNumber numberWithFloat:1.0]];
        [fade setToValue:[NSNumber numberWithFloat:0.0]];
        [fade setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [fade setRepeatCount:HUGE_VALF];
        [fade setDuration:kDefaultSpeed];
        CGFloat markerAnimationDuration = kDefaultSpeed/kDefaultNumberOfSpinnerMarkers;
        [self setInstanceDelay:markerAnimationDuration];
        [marker addAnimation:fade forKey:kMarkerAnimationKey];
    }
    return self;
}

@end
