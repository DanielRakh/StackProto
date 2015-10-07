//
//  FeedViewController.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedViewControllerCell.h"
#import "UIColor+ColorPalette.h"
#import "ColorQueue.h"
#import "DataManager.h"
#import "StackViewController.h"


@interface FeedViewController ()

@property (nonatomic) NSArray *users;
@property (nonatomic) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundWhiteColor];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor sonicBlueColor];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView addSubview:self.refreshControl];
    
    [self.refreshControl beginRefreshing];
    
    [[DataManager sharedManager]usersFeed:^(BOOL finished, NSArray *users) {
        if (finished) {
            NSLog(@"%@",users);
            self.users = users;
            [self.refreshControl endRefreshing];
            [self.collectionView reloadData];
        }
    }];
    
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self firstTimeLaunched]) {
        [self performSegueWithIdentifier:@"CreateUser" sender:nil];
    }
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.users.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedViewControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FeedCell" forIndexPath:indexPath];
//    cell.contentView.backgroundColor = [[ColorQueue sharedManager] popAndRecycleColor];
    NSString *initials = self.users[indexPath.row][@"username"];
    cell.nameInitials.text =  [initials substringToIndex:2];
    cell.contentView.backgroundColor = [UIColor sonicBlueColor];
    return cell;
}


- (void)refresh:(id)sender {
    
    [[DataManager sharedManager]usersFeed:^(BOOL finished, NSArray *users) {
        if (finished) {
            NSLog(@"%@",users);
            self.users = users;
            [self.refreshControl endRefreshing];
            [self.collectionView reloadData];
        }
    }];
}


#pragma mark - Check for first launch

- (BOOL)firstTimeLaunched {
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    
    return NO;
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"pushToStackView"]) {
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        StackViewController *stackVC = (StackViewController *)segue.destinationViewController;
        stackVC.userInfo = self.users[indexPath.item];
    }
}

@end
