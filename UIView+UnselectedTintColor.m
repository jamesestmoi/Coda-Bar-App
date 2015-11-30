//
//  UIView+UnselectedTintColor.m
//  Bar Design
//
//  Created by James Pickering on 8/9/15.
//  Copyright (c) 2015 James Pickering. All rights reserved.
//

#import "UIView+UnselectedTintColor.h"

@implementation UIView (UIView_UnselectedTintColor)

+ (instancetype)swift_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    
    return [self appearanceWhenContainedIn:containerClass, nil];
}

@end
