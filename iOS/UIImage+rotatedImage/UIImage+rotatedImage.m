#import "UIImage+rotatedImage.h"

@implementation UIImage (rotatedImage)

- (UIImage *)rotatedImageWithDegrees:(CGFloat)degrees
{
    return [self rotatedImageWithRadians:degrees * M_PI / 180.0];
}

- (UIImage *)rotatedImageWithRadians:(CGFloat)radians
{
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGRect rotatedRect = CGRectApplyAffineTransform(imageRect, CGAffineTransformMakeRotation(radians));
    
    UIGraphicsBeginImageContextWithOptions(rotatedRect.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // アンチエイリアスをオンにする
	CGContextSetShouldAntialias(context, true);
	CGContextSetAllowsAntialiasing(context, true);
    
    // 補完方法の指定
	CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    // Transform Matrixの設定
	CGContextTranslateCTM(context, rotatedRect.size.width * 0.5, rotatedRect.size.height * 0.5);
    CGContextScaleCTM(context, 1.0, -1.0);
	CGContextRotateCTM(context, radians);
    
    // 画像を描画
    CGRect rotatedImageRect = CGRectMake(0 - imageRect.size.width / 2.0, 0 - imageRect.size.height / 2.0, imageRect.size.width, imageRect.size.height);
	CGContextDrawImage(context, rotatedImageRect, self.CGImage);
    
    // 画像を取得
	CGImageRef rotatedImageRef = CGBitmapContextCreateImage(context);
	UIImage *rotatedImage = [UIImage imageWithCGImage:rotatedImageRef scale:self.scale orientation:self.imageOrientation];
	CGImageRelease(rotatedImageRef);
    
    UIGraphicsEndImageContext();
    
    return rotatedImage;
}

@end
