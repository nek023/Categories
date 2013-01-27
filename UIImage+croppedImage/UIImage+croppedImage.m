//
//  UIImage+croppedImage.m
//  CroppedImage
//
//  Created by Katsuma Tanaka on 2013/01/27.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "UIImage+croppedImage.h"

@implementation UIImage (croppedImage)

- (UIImage *)croppedImageToRect:(CGRect)rect
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGRect scaledRect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * 2);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, scaledRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

@end
