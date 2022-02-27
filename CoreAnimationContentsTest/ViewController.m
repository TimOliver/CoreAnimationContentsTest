//
//  ViewController.m
//  CoreAnimationContentsTest
//
//  Created by Tim Oliver on 26/2/2022.
//

#import "ViewController.h"
#import "ICPageImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ICPageImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.imageView.sourceImage = [UIImage imageNamed:@"1.jpg"];
    self.imageView.destImage = [UIImage imageNamed:@"2.jpg"];
}

- (IBAction)valueChanged:(id)sender {
    self.imageView.fraction = self.slider.value;
}

@end
