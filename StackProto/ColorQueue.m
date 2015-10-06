//
//  ColorQueue.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "ColorQueue.h"
#import "UIColor+ColorPalette.h"

@interface ColorQueue ()

@property (nonatomic) NSMutableArray *colors;

@end


@implementation ColorQueue

+ (instancetype)sharedManager {
    static ColorQueue *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] initWithColors:@[[UIColor midnightBlueColor],
                                                         [UIColor lightBlueColor],
                                                         [UIColor lightPurpleColor],
                                                         [UIColor darkPurpleColor]]];
    });
    return sharedMyManager;
}


- (instancetype)initWithColors:(NSArray *)colors {
    
    self = [super init];
    if (self) {
        _colors = [NSMutableArray arrayWithArray:colors];
    }
    return self;
}


- (UIColor *)popAndRecycleColor {
    
    UIColor *topColor = self.colors.firstObject;
    [self.colors removeObjectAtIndex:0];
    [self.colors addObject:topColor];
    return topColor;
}

@end
