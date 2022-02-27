//
//  ICPageImageView.m
//  CoreAnimationContentsTest
//
//  Created by Tim Oliver on 27/2/2022.
//

#import "ICPageImageView.h"

inline static CGRect ICPageImageViewScaledRect(CGRect rect, CGFloat scale) {
    rect.origin.x *= scale;
    rect.origin.y *= scale;
    rect.size.width *= scale;
    rect.size.height *= scale;
    return rect;
}

@interface ICPageImageView ()

@property (nonatomic, strong) EAGLContext *eaglContext;
@property (nonatomic, strong) CIContext *ciContext;

@property (nonatomic, strong) CIImage *sourceCIImage;
@property (nonatomic, strong) CIImage *destCIImage;

@end

@implementation ICPageImageView

#pragma mark - Instance Creation -

- (instancetype)init
{
    self = [super init];
    if (self) { [self commonInit]; }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { [self commonInit]; }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) { [self commonInit]; }
    return self;
}

#pragma mark - Set-up and Configuration -

- (void)commonInit
{
    // Configure OpenGL ES
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.ciContext = [CIContext contextWithEAGLContext:self.context];
}

- (void)draw
{
    if (self.sourceCIImage == nil && self.destCIImage == nil) { return; }

    CGFloat scale = [[UIScreen mainScreen] scale];
    CGRect frame = ICPageImageViewScaledRect(self.bounds, scale);
    CIImage *output = nil;

    // Determine what to draw
    if (self.destCIImage != nil) {
        CIFilter *filter = [CIFilter filterWithName:@"CIDissolveTransition"
                                withInputParameters:@{ kCIInputImageKey: self.sourceCIImage,
                                                       kCIInputTargetImageKey: self.destCIImage,
                                                       kCIInputTimeKey: @(self.fraction)}];
        output = filter.outputImage;
    } else {
        output = self.sourceCIImage;
    }

    // Draw the image via OpenGL
    [self bindDrawable];
    [self.ciContext drawImage:output inRect:frame fromRect:self.sourceCIImage.extent];
    [self display];
}

#pragma mark - Accessors -

- (void)setSourceImage:(UIImage *)sourceImage
{
    if (sourceImage == _sourceImage) { return; }
    _sourceImage = sourceImage;
    self.sourceCIImage = [[CIImage alloc] initWithImage:sourceImage];
    [self draw];
}

- (void)setDestImage:(UIImage *)destImage
{
    if (destImage == _destImage) { return; }
    destImage = destImage;
    self.destCIImage = [[CIImage alloc] initWithImage:destImage];
}

- (void)setFraction:(CGFloat)fraction
{
    _fraction = fraction;
    [self draw];
}

@end
