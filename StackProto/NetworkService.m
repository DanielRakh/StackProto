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

static NSString *usersEndPointURL = @"https://stack-prototype.herokuapp.com/users";
static NSString *postsEndPointURL = @"https://stack-prototype.herokuapp.com/posts";


+ (id)sharedManager {
    static NetworkService *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (void)getUsers:(didFinishLoading)compBlock {
    
    __block NSArray *users;
    
    NSURL *url = [NSURL URLWithString:postsEndPointURL];
    
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
        
//        NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        users = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingAllowFragments error:nil];
        
        compBlock(YES,users);
        
    }] resume];
    

}


- (NSString *)postNewUserWithUsername:(NSString *)username {
    
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
            if (statusCode != 201) {
                NSLog(@"dataTaskWithRequest HTTP status code: %ld", statusCode);
                return;
            }
        }
        
        // otherwise, everything is probably fine and you should interpret the `data` contents
        
        NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSMutableDictionary *userDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:userDict[@"id"] forKey:@"user"];
        [defaults setValue:userDict[@"username"] forKey:@"username"];
        [defaults synchronize];
    
        }] resume];
    
    return nil;
}



- (void)postLink:(NSString *)link forUser:(NSString *)userID {
    
    NSURL *url =  [NSURL URLWithString:postsEndPointURL];
    
    NSDictionary *userDict = @{@"post" : @{@"user_id" : userID, @"content" : link}};
    
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
            if (statusCode != 201) {
                NSLog(@"dataTaskWithRequest HTTP status code: %ld", statusCode);
                return;
            }
        }
        
        // otherwise, everything is probably fine and you should interpret the `data` contents
        
        NSLog(@"SUCESSFUL POST");
    
    }] resume];

}


@end
