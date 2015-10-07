//
//  UserViewController.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "UserViewController.h"
#import "ThinlineButton.h"
#import "DataManager.h"

@interface UserViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet ThinlineButton *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    self.doneButton.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    self.doneButton.alpha = 0.0;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger length = [[textField text] length] - range.length + string.length;
    
    if (length == 1) {
        [self animateButtonToReveal:YES];
    } else if (length == 0) {
        [self animateButtonToReveal:NO];
    }
    
    return YES;
}
- (IBAction)closeButtonDidTap:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)doneButtonDidTap:(id)sender {
    
    
    [[DataManager sharedManager] createNewUserWithName:self.textField.text];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)animateButtonToReveal:(BOOL)reveal {
    [UIView animateWithDuration:0.5 delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.doneButton.transform = reveal ? CGAffineTransformIdentity : CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                         self.doneButton.alpha = reveal ? 1.0 : 0;
                     } completion:^(BOOL finished) {
                         //
                     }];
}

@end
