//
//  ViewController.m
//  CoreAnimationContentsTest
//
//  Created by Tim Oliver on 26/2/2022.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    UIImage *fromImage = [UIImage imageNamed:@"1.jpg"];
    UIImage *toImage = [UIImage imageNamed:@"2.jpg"];

    self.imageView.image = fromImage;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    animation.fromValue = (id)fromImage.CGImage;
    animation.toValue = (id)toImage.CGImage;
    animation.duration = 1.0f;
    [self.imageView.layer addAnimation:animation forKey:@"contents"];
    self.imageView.image = toImage;
    self.imageView.layer.speed = 0.0f;
}

- (IBAction)valueChanged:(id)sender {
    self.imageView.layer.timeOffset = self.slider.value;

}

@end
