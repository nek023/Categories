//
//  UIImage+scaledImage.m
//  HungryMap
//
//  Created by Katsuma Tanaka on 2013/02/07.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "UIImage+scaledImage.h"

@implementation UIImage (resizedImage)

- (UIImage *)resizedImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

@end
