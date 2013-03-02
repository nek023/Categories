#import "NSImage+resizedImage.h"

@implementation NSImage (resizedImage)

- (NSImage *)resizedImageWithSize:(CGSize)size
{
    NSImage *resizedImage = [[NSImage alloc] initWithSize:size];
    
    [resizedImage lockFocus];
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height) fromRect:CGRectMake(0, 0, self.size.width, self.size.height) operation:NSCompositeSourceOver fraction:1.0];
    
    [resizedImage unlockFocus];
    
    return [resizedImage autorelease];
}

@end
