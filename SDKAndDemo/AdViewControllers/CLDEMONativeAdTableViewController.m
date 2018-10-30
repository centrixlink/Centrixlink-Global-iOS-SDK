//
//  CLDEMONativeAdTableViewController.m
//

//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import "CLDEMONativeAdTableViewController.h"
#import <CentrixlinkGlobal/CentrixlinkGlobal.h>
#import <Masonry.h>
#import "CLDEMONativeAdNormalFeedTableViewCell.h"
#import "CLDEMONativeAdFeedTableViewCell.h"
#import "CLDEMOAppInfo.h"
#import "CLDEMOLog.h"

@interface CLDEMONativeAdTableViewController () <CLGlobalNativeAdDelegate> {
  UIView *configView;
}

@property (nonatomic, strong) NSMutableArray    *arrFeed;
@property (nonatomic, strong) NSMutableArray    *arrAds;
@property (nonatomic, strong) NSMutableDictionary *mdictAdIndexMap;
@end

@implementation CLDEMONativeAdTableViewController

- (NSArray *)arrPlacementID {
  return @[
           @"5b8613b428eb3a70ce5e8030",  //100
           @"5b8613c328eb3a70ce5e86a4",  //120
           @"5b8613d528eb3a70ce5eb095",  //300
           @"5b8613e528eb3a70ce5eb8ee"   //400
           ];
}

- (IBAction)refreshNativeAd:(id)sender {
  NSMutableArray *marrOrigin = [self.arrFeed mutableCopy];
  [self.arrFeed enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if ([obj isKindOfClass:[CLGlobalNativeAd class]]) {
      [marrOrigin removeObject:obj];
    }
  }];
  self.arrFeed = [marrOrigin mutableCopy];
  [self.arrAds enumerateObjectsUsingBlock:^(CLGlobalNativeAd * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj loadAd];
  }];
  [self.tableView reloadData];
}

- (NSString *)sectionHeaderNibName {
  return @"CLDEMONativeAdLoadView";
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"NativeAd In TableView";
  
  [self.tableView registerNib:[UINib nibWithNibName:@"CLDEMONativeAdFeedTableViewCell"
                                             bundle:nil]
       forCellReuseIdentifier:@"CLDEMONativeAdFeedTableViewCell"];
  [self.tableView registerNib:[UINib nibWithNibName:@"CLDEMONativeAdNormalFeedTableViewCell"
                                             bundle:nil]
       forCellReuseIdentifier:@"CLDEMONativeAdNormalFeedTableViewCell"];
  
  [self configFeedItems];
  [self configAdItems];

}

- (void)configAdItems {
  self.arrAds = [NSMutableArray arrayWithCapacity:10];
  [[self arrPlacementID] enumerateObjectsUsingBlock:^(NSString * _Nonnull placementId, NSUInteger idx, BOOL * _Nonnull stop) {
    CLGlobalNativeAd *nativeAd = [[CLGlobalNativeAd alloc] initWithPlacementID:placementId];
    nativeAd.delegate = self;
    [self.arrAds addObject:nativeAd];
    [nativeAd loadAd];
  }];
}

- (void)configFeedItems {
  NSMutableArray *marrFeed = [NSMutableArray arrayWithCapacity:0];
  /// 8 normal feed items, after loading native ad
  /// 12 in total.
  for (NSInteger index = 0; index < 8; index++) {
    [marrFeed addObject:@(index)];
  }
  self.arrFeed = [marrFeed mutableCopy];
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return self.arrFeed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  id feedItem = self.arrFeed[indexPath.row];
  if ([feedItem isKindOfClass:[CLGlobalNativeAd class]]) {
    CLGlobalNativeAd *nativeAd = feedItem;
    UITableViewCell *cell = [nativeAd tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell;
  } else {
    CLDEMONativeAdNormalFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLDEMONativeAdNormalFeedTableViewCell" forIndexPath:indexPath];
    cell.lblTitle.text = [feedItem stringValue];
    return cell;
  }
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  id feedItem = self.arrFeed[indexPath.row];
  if ([feedItem isKindOfClass:[CLGlobalNativeAd class]]) {
    return [feedItem tableView:tableView heightForRowAtIndexPath:indexPath];
  }
  return 100;
}

#pragma mark - NativeAd Delegate
- (void)nativeAdLoadFinished:(CLGlobalNativeAd *)nativeAd
                       error:(NSError *)loadError {
  if (loadError) {
    [CLDEMOLog log:@"native ad load error" message:nil];
  } else {
    /// handle native ad load success
    /// insert into all feed array
    /// you can insert native ad with
    /// your own logic
    NSInteger index = [self.arrAds indexOfObject:nativeAd];
    [self appendNativeAdAtIndex:index nativeAd:nativeAd];
  }
}

- (void)appendNativeAdAtIndex:(NSInteger)index nativeAd:(CLGlobalNativeAd *)nativeAdT {
  if (self.mdictAdIndexMap == nil) {
    self.mdictAdIndexMap = [NSMutableDictionary dictionaryWithCapacity:10];
  }
  NSInteger indexToInsert = index * 3;
  self.mdictAdIndexMap[@(indexToInsert)] = nativeAdT;
  if (indexToInsert >= self.arrFeed.count) {
    return;
  }
  NSMutableArray *marrPlaceholder = [self.arrFeed mutableCopy];
  [self.arrFeed enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if ([obj isKindOfClass:[CLGlobalNativeAd class]]) {
      [marrPlaceholder removeObject:obj];
    }
  }];
  for (NSInteger index = 0; index < 4; index++) {
    [marrPlaceholder insertObject:[NSNull null] atIndex:index * 3];
  }
  for (NSNumber *indexKey in self.mdictAdIndexMap.allKeys) {
    [marrPlaceholder replaceObjectAtIndex:[indexKey integerValue] withObject:self.mdictAdIndexMap[indexKey]];
  }
  NSMutableArray *arrFeedResult = [marrPlaceholder mutableCopy];
  [arrFeedResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if ([obj isKindOfClass:[NSNull class]]) {
      [marrPlaceholder removeObject:obj];
    }
  }];
  self.arrFeed = marrPlaceholder;
  [self.tableView reloadData];
}

- (void)nativeAdDisplayFinished:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  if (error) {
    [CLDEMOLog log:@"display error" message:nil];
  }
}

- (void)nativeAdImpressionFinished:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  
}
/// succeded if error equals nil
- (void)nativeAdDidClickCTA:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  
}

- (void)nativeAdApplicationDidBecomeActive:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  [CLDEMOLog log:@"did become active" message:nil];
}

- (void)nativeAdApplicationWillResignActive:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  [CLDEMOLog log:@"will resign active" message:nil];
}

- (void)nativeAdDidDismissPreview:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  [CLDEMOLog log:@"dismiss preview" message:nil];
}

- (void)nativeAdWillShowPreview:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  [CLDEMOLog log:@"will show preview" message:nil];
}

@end
