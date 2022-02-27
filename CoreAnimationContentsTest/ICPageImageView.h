//
//  ICPageImageView.h
//  CoreAnimationContentsTest
//
//  Created by Tim Oliver on 27/2/2022.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICPageImageView : GLKView

@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) UIImage *destImage;

@property (nonatomic, assign) CGFloat fraction;

@end

NS_ASSUME_NONNULL_END
