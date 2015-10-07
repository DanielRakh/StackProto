//
//  FeedViewControllerCell.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "FeedViewControllerCell.h"

@implementation FeedViewControllerCell


- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.contentView.frame = bounds;
}



- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.layer.cornerRadius = self.bounds.size.height / 2.0;
}



@end
