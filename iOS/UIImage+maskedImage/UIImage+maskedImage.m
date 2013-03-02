#import "UIImage+maskedImage.h"

@implementation UIImage (maskedImage)

- (UIImage *)maskedImageWithImage:(UIImage *)maskImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // アンチエイリアスをオンにする
	CGContextSetShouldAntialias(context, true);
	CGContextSetAllowsAntialiasing(context, true);
    
    // 補完方法の指定
	CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
	CGImageRef maskImageRef = CGImageMaskCreate((size_t)maskImage.size.width, (size_t)maskImage.size.height, CGImageGetBitsPerComponent(maskImage.CGImage), CGImageGetBitsPerPixel(maskImage.CGImage), CGImageGetBytesPerRow(maskImage.CGImage), CGImageGetDataProvider(maskImage.CGImage), NULL, false);
    
    // マスクを適用
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextDrawImage(context, imageRect, self.CGImage);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    CGImageRef maskedImageRef = CGImageCreateWithMask(imageRef, maskImageRef);
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedImageRef];
    
	CGImageRelease(maskedImageRef);
	CGImageRelease(imageRef);
	CGImageRelease(maskImageRef);
    
    UIGraphicsEndImageContext();
    
    return maskedImage;
}

@end
