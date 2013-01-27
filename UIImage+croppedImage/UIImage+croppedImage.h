//
//  UIImage+croppedImage.h
//  CroppedImage
//
//  Created by Katsuma Tanaka on 2013/01/27.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (croppedImage)

- (UIImage *)croppedImageToRect:(CGRect)rect;

@end
