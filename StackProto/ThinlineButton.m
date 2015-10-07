//
//  ThinlineButton.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "ThinlineButton.h"
#import "UIColor+ColorPalette.h"

@implementation ThinlineButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


- (void)initialize {
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 4.0;
    self.layer.borderColor = [UIColor sonicBlueColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    self.titleLabel.textColor = [UIColor sonicBlueColor];
    
//    [self setTitleColor:[UIColor HNOrange] forState:UIControlStateNormal];
    //    [self setTitle:@"XX Comments" forState:UIControlStateNormal];
    
}

@end
