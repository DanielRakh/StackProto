//
//  User.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithUsername:(NSString *)username {
    self = [super init];
    if (self) {
        _username = username;
    }
    
    return self;
}

@end
