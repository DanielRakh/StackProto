//
//  DataManager.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "DataManager.h"
#import "NetworkService.h"
#import "User.h"



@implementation DataManager



+ (instancetype)sharedManager {
    static DataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (void)createNewUserWithName:(NSString *)username {
    
    [[NetworkService sharedManager]postNewUserWithUsername:username];
}




- (void)usersFeed:(didFinishLoading)compBlock {
    
    [[NetworkService sharedManager]getUsers:^(BOOL finished, NSArray *users) {
        compBlock(finished, users);
    }];
    
}

- (void)pushLink:(NSString *)link {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults valueForKey:@"user"];
    [[NetworkService sharedManager]postLink:link forUser:userID];
    
}



@end
