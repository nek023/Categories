//
//  NSDate+stringWithFormat.m
//  Retype
//
//  Created by Katsuma Tanaka on 2012/12/25.
//  Copyright (c) 2012年 Katsuma Tanaka. All rights reserved.
//

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
