#import "NSImage+PNGRepresentation.h"

@implementation NSImage (PNGRepresentation)

- (NSData *)PNGRepresentation
{
    [self lockFocus];
    NSBitmapImageRep *bitmapImageRep = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0, 0, self.size.width, self.size.height)];
    [self unlockFocus];
    
    NSData *representation = [bitmapImageRep representationUsingType:NSPNGFileType properties:nil];
    [bitmapImageRep release];
    
    return representation;
}

@end
