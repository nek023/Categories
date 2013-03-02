@interface UIImage (resizedImage)

- (UIImage *)resizedImageWithSize:(CGSize)size;

- (UIImage *)scaledImageWithFactor:(CGFloat)factor;

- (UIImage *)scaledImageToFitSize:(CGSize)size;
- (UIImage *)scaledImageToFillSize:(CGSize)size;

@end
