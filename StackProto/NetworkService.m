//
//  NetworkService.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "NetworkService.h"


@interface NetworkService ()

@end

@implementation NetworkService

static NSString *usersEndPointURL = @"http://192.168.3.123:3000/users";

+ (id)sharedManager {
    static NetworkService *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (NSData *)getUsers {
    
    NSData *users;
    
    NSURL *url = [NSURL URLWithString:usersEndPointURL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"dataTaskWithRequest error: %@", error);
            return;
        }
        
        // handle HTTP errors here
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode != 200) {
                NSLog(@"dataTaskWithRequest HTTP status code: %ld", statusCode);
                return;
            }
        }
        
        // otherwise, everything is probably fine and you should interpret the `data` contents
        
        NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }] resume];

    return nil;
}


- (void)postNewUserWithUsername:(NSString *)username {
    
    NSURL *url =  [NSURL URLWithString:usersEndPointURL];
    
    NSDictionary *userDict = @{@"user" : @{@"username" : username}};

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:userDict options:0 error:nil];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"dataTaskWithRequest error: %@", error);
            return;
        }
        
        // handle HTTP errors here
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode != 200) {
                NSLog(@"dataTaskWithRequest HTTP status code: %ld", statusCode);
                return;
            }
        }
        
        // otherwise, everything is probably fine and you should interpret the `data` contents
        
        NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
    
        }] resume];
    
}







@end
