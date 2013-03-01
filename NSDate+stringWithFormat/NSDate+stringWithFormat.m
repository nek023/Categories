#import "NSDate+stringWithFormat.h"

@implementation NSDate (stringWithFormat)

- (NSString *)stringWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    NSString *resultString = [dateFormatter stringFromDate:self];
    [dateFormatter release];
    
    return resultString;
}

@end
