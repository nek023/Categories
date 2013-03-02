#import "UIImage+resizedImage.h"

@implementation UIImage (resizedImage)

- (UIImage *)resizedImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // アンチエイリアスをオンにする
	CGContextSetShouldAntialias(context, true);
	CGContextSetAllowsAntialiasing(context, true);
    
    // 補完方法の指定
	CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    // 画像を描画
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (UIImage *)scaledImageWithFactor:(CGFloat)factor
{
    CGSize scaledSize = CGSizeMake(self.size.width * factor, self.size.height * factor);
    
    return [self resizedImageWithSize:scaledSize];
}

- (UIImage *)scaledImageToFitSize:(CGSize)size
{
    CGSize scaledSize;
    
    if(size.width > size.height) {
        scaledSize = CGSizeMake(size.width, (size.width / self.size.width) * self.size.height);
        
        if(scaledSize.height > size.height) {
            scaledSize = CGSizeMake((size.height / self.size.height) * self.size.width, size.height);
        }
    } else {
        scaledSize = CGSizeMake((size.height / self.size.height) * self.size.width, size.height);
        
        if(scaledSize.width > size.width) {
            scaledSize = CGSizeMake(size.width, (size.width / self.size.width) * self.size.height);
        }
    }
    
    return [self resizedImageWithSize:scaledSize];
}

- (UIImage *)scaledImageToFillSize:(CGSize)size
{
    CGSize scaledSize;
    
    if(size.width > size.height) {
        scaledSize = CGSizeMake(size.width, (size.width / self.size.width) * self.size.height);
        
        if(scaledSize.height < size.height) {
            scaledSize = CGSizeMake((size.height / self.size.height) * self.size.width, size.height);
        }
    } else {
        scaledSize = CGSizeMake((size.height / self.size.height) * self.size.width, size.height);
        
        if(scaledSize.width < size.width) {
            scaledSize = CGSizeMake(size.width, (size.width / self.size.width) * self.size.height);
        }
    }
    
    return [self resizedImageWithSize:scaledSize];
}

@end
