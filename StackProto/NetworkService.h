//
//  NetworkService.h
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject

+ (id)sharedManager;


- (NSData *)getUsers;
- (void)postNewUserWithUsername:(NSString *)username; 

@end
