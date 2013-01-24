//
//  UIView+findFirstResponder.m
//  SocialRack
//
//  Created by questbeat on 12/06/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+findFirstResponder.h"

@implementation UIView (findFirstResponder)

- (UIView *)findFirstResponder
{
    if(self.isFirstResponder)
        return self;
    
    for(UIView *subview in self.subviews) {
        UIView *firstResponder = [subview findFirstResponder];
        
        if(firstResponder != nil)
            return firstResponder;
    }
    
    return nil;
}

@end
