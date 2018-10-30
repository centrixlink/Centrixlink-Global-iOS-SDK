//
//  CLDEMONativeAdCollectionViewController.m
//  SDKAndDemo
//
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import "CLDEMONativeAdCollectionViewController.h"
#import <CentrixlinkGlobal/CentrixlinkGlobal.h>
#import "CLDEMOLog.h"

@interface CLDEMONativeAdCollectionViewController ()<UICollectionViewDelegateFlowLayout, CLGlobalNativeAdDelegate>

@property (nonatomic, strong) NSMutableArray *arrAllFeed;
@property (nonatomic, strong) NSMutableArray *arrNativeAds;
@property (nonatomic, strong) NSArray        *arrNativeAdIDs;
@end

@implementation CLDEMONativeAdCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
  return [[CLDEMONativeAdCollectionViewController alloc] initWithNibName:@"CLDEMONativeAdCollectionViewController" bundle:nil];
}

- (NSArray *)arrPlacementID {
  return @[
           @"5b8613b428eb3a70ce5e8030",
           @"5b8613c328eb3a70ce5e86a4",
           @"5b8613d528eb3a70ce5eb095",
           @"5b8613e528eb3a70ce5eb8ee",
           ];
}

/// called when native ad load finished, if succeded,
/// with nil loadError, otherwise, nil nativeAdView and non-nil loadError
- (void)nativeAdLoadFinished:(CLGlobalNativeAd *)nativeAd
                       error:(NSError *)loadError {
  if (loadError) {
    [CLDEMOLog log:@"native ad load error" message:nil];
  } else {
    // you can use more efficient method
    // to handle reload
    NSInteger index = [self.arrNativeAds indexOfObject:nativeAd];
    [self.arrAllFeed replaceObjectAtIndex:index withObject:nativeAd];
    [self.collectionView reloadData];
  }
}

- (void)nativeAdDisplayFinished:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  if (error) {
    // handle error
    [CLDEMOLog log:@"display error" message:nil];
  } else {
    
  }
}

// called when native ad impression trackings sent
- (void)nativeAdImpressionFinished:(CLGlobalNativeAd *)nativeAd
                             error:(NSError *)error {
  
}
/// succeded if error equals nil
- (void)nativeAdDidClickCTA:(CLGlobalNativeAd *)nativeAd
                      error:(NSError *)error {
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"NativeAd In Collection View";
  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.arrNativeAdIDs = [self arrPlacementID];
  self.arrAllFeed = [NSMutableArray arrayWithCapacity:10];
  self.arrNativeAds = [NSMutableArray arrayWithCapacity:10];
  for (NSInteger index = 0; index < self.arrNativeAdIDs.count; index++) {
      CLGlobalNativeAd *nativeAd = [[CLGlobalNativeAd alloc] initWithPlacementID:self.arrNativeAdIDs[index]];
      nativeAd.delegate = self;
      [nativeAd loadAd];
    [self.arrNativeAds addObject:nativeAd];
    [self.arrAllFeed addObject:[NSNull null]];
  }
  
  // Register cell classes
  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  id item = self.arrAllFeed[indexPath.item];
  if ([item isKindOfClass:[CLGlobalNativeAd class]]) {
    CLGlobalNativeAd *nativeAd = item;
    CGSize size = [nativeAd collectionView:collectionView layout:collectionViewLayout heightForItemAtIndexPath:indexPath itemWidth:320];
    return size;
  } else {
    return CGSizeZero;
  }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrAllFeed.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  id item = self.arrAllFeed[indexPath.item];
  if ([item isKindOfClass:[CLGlobalNativeAd class]]) {
    CLGlobalNativeAd *nativeAd = item;
    UICollectionViewCell *cell = [nativeAd collectionView:collectionView cellForItemAtIndexPath:indexPath];
    return cell;
  } else {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
  }
}

@end
