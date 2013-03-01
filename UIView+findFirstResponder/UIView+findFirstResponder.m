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
