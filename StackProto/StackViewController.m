//
//  StackViewController.m
//  StackProto
//
//  Created by Daniel on 10/6/15.
//  Copyright © 2015 Daniel Rakhamimov. All rights reserved.
//

#import "StackViewController.h"
#import "StackCell.h"
@import SafariServices;

@interface StackViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation StackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.pagingEnabled = YES;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    StackCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StackCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    cell.linkLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    return cell;
}

- (IBAction)openButtonDidTap:(id)sender {
    
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://www.reddit.com"] entersReaderIfAvailable:YES];
    safariVC.delegate = self;
    
    [self presentViewController:safariVC animated:YES completion:nil];
}


#pragma mark - SFSafarViewControllerDelegate

- (NSArray<UIActivity *> *)safariViewController:(SFSafariViewController *)controller activityItemsForURL:(NSURL *)URL title:(nullable NSString *)title {
    
    return nil;
}



@end
