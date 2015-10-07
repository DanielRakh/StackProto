//
//  NetworkService.h
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^didFinishLoading)(BOOL, NSArray *);

@interface NetworkService : NSObject

+ (id)sharedManager;


- (void)getUsers:(didFinishLoading)compBlock;

- (NSString *)postNewUserWithUsername:(NSString *)username;
- (void)postLink:(NSString *)link forUser:(NSString *)userID;

@end
