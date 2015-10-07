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

@end

@implementation FeedViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundWhiteColor];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor blackColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    
    
    [[DataManager sharedManager]usersFeed:^(BOOL finished, NSArray *users) {
        if (finished) {
            NSLog(@"%@",users);
            self.users = users;
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
    cell.contentView.backgroundColor = [[ColorQueue sharedManager] popAndRecycleColor];
    return cell;
}


- (void)refresh:(id)sender {
    
    NSLog(@"REFRESH!");
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
