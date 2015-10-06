//
//  DataManager.h
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (instancetype)sharedManager;


- (NSArray *)usersFeed;

- (void)createNewUserWithName:(NSString *)username;



@end
