//
//  DataManager.h
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^didFinishLoading)(BOOL, NSArray *);


@class User;
@interface DataManager : NSObject

+ (instancetype)sharedManager;


- (void)usersFeed:(didFinishLoading)compBlock;

- (void)createNewUserWithName:(NSString *)username;
- (void)pushLink:(NSString *)link;



@end
