//
//  PostViewController.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "PostViewController.h"
#import "ThinlineButton.h"
#import "DataManager.h"
#import "UIColor+ColorPalette.h"

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
@property (weak, nonatomic) IBOutlet ThinlineButton *pasteButton;
@property (weak, nonatomic) IBOutlet ThinlineButton *postButton;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postButton.alpha = 0;
    self.linkLabel.alpha = 0;
    self.postButton.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.linkLabel.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.postButton.layer.borderColor = [UIColor appleGreenColor].CGColor;
    self.postButton.titleLabel.textColor = [UIColor appleGreenColor];
    
    
}

- (IBAction)pasteButtonDidTap:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    self.linkLabel.text = pasteboard.string;
    
    [UIView animateWithDuration:0.15
                     animations:^{
                         self.pasteButton.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:0.0
                               usingSpringWithDamping:0.35
                               initialSpringVelocity:0.35
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              self.postButton.alpha = 1.0;
                                              self.postButton.transform = CGAffineTransformIdentity;
                                              self.linkLabel.alpha = 1.0;
                                              self.linkLabel.transform = CGAffineTransformIdentity;
                                    
                                          } completion:^(BOOL finished) {
                                              //
                                          }];
                     }];
    
}


- (IBAction)postButtonDidTap:(id)sender {
    
    
    [[DataManager sharedManager]pushLink:self.linkLabel.text];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismissButtonDidTap:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
