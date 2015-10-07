//
//  StackViewController.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "StackViewController.h"
#import "StackCell.h"
#import "UIColor+ColorPalette.h"
#import "User.h"
@import SafariServices;


@interface StackViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation StackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor backgroundWhiteColor];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(375, 667);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *postsArray = self.userInfo[@"posts"];
    return postsArray.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StackCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StackCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    NSDictionary *item = self.userInfo[@"posts"][indexPath.item];
    cell.linkLabel.text = item[@"content"];
    return cell;
}

- (IBAction)openButtonDidTap:(id)sender {

    NSIndexPath *currentIndexPath = self.collectionView.indexPathsForVisibleItems[0];
    
    NSDictionary *item = self.userInfo[@"posts"][currentIndexPath.item];
    
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:item[@"content"]] entersReaderIfAvailable:YES];
    safariVC.delegate = self;
    
    [self presentViewController:safariVC animated:YES completion:nil];
}


#pragma mark - SFSafarViewControllerDelegate

- (NSArray<UIActivity *> *)safariViewController:(SFSafariViewController *)controller activityItemsForURL:(NSURL *)URL title:(nullable NSString *)title {
    
    return nil;
}



@end
