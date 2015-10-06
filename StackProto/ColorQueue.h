//
//  ColorQueue.h
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ColorQueue : NSObject

+ (instancetype)sharedManager;


- (UIColor *)popAndRecycleColor;


@end
