//
//  FeedViewController.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedViewControllerCell.h"

@interface FeedViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedViewControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FeedCell" forIndexPath:indexPath];
    return cell;
}

@end
