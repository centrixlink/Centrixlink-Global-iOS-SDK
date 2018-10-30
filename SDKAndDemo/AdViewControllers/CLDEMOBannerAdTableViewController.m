//
//  CLGlobalBannerAdViewController.m
//
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import "CLDEMOBannerAdTableViewController.h"
#import "CLDEMOBannerAdContainerTableViewCell.h"
#import "CLDEMOBannerAdInvalidTableViewCell.h"
#import <Masonry.h>
#import <CentrixlinkGlobal/CentrixlinkGlobal.h>
#import "CLDEMOLog.h"
#import "CLDEMOAppInfo.h"

@interface CLDEMOBannerAdTableViewController () <CLGlobalBannerAdDelegate> {
  NSMutableArray *marrBannerAds;
}

@property (weak, nonatomic) IBOutlet UIView *banner_320_50;
@property (weak, nonatomic) IBOutlet UIView *banner_300_250;


@end

@implementation CLDEMOBannerAdTableViewController

- (CGFloat)tableViewSectionHeaderHeight {
  return 500;
}

- (NSString *)sectionHeaderNibName {
  return @"CLDEMOBannerAdDisplayContainerView";
}

#pragma mark - IB Click
- (IBAction)loadBannerAd:(id)sender {
  [marrBannerAds enumerateObjectsUsingBlock:^(CLGlobalBannerAd *_Nonnull bannerAd, NSUInteger idx, BOOL * _Nonnull stop) {
      [bannerAd loadAd];
  }];
}

- (IBAction)showBannerAd:(id)sender {
  __weak typeof(self)weakSelf = self;
  [marrBannerAds enumerateObjectsUsingBlock:^(CLGlobalBannerAd *_Nonnull bannerAd, NSUInteger idx, BOOL * _Nonnull stop) {
    if ([self is320_50_Banner:bannerAd]) {
      [bannerAd renderBannerAdViewInContainer:weakSelf.banner_320_50];
    } else {
      [bannerAd renderBannerAdViewInContainer:weakSelf.banner_300_250];
    }
  }];
}

- (BOOL)is320_50_Banner:(CLGlobalBannerAd *)bannerAd {
  return bannerAd == [marrBannerAds firstObject];
}

#pragma mark - BannerAdDelegate
- (void)bannerAdLoadFinished:(CLGlobalBannerAd *)bannerAd
                      error:(NSError *)error {
  if (error) {
    [CLDEMOLog log:@"banner load error" message:nil];
  }
}

- (void)bannerAdImpressionFinished:(CLGlobalBannerAd *)bannerAd error:(NSError *)error {
  
}

- (void)bannerAdDidClick:(CLGlobalBannerAd *)bannerAd error:(NSError *)error {
  
}

- (void)bannerAdDisplay:(CLGlobalBannerAd *)bannerAd error:(NSError *)error {
  if (error) {
    [CLDEMOLog log:@"display error" message:nil];
  }
}

- (void)bannerAdApplicationDidBecomeActive:(CLGlobalBannerAd *)bannerAd error:(NSError *)error {
//  NSLog(@"%s",__FUNCTION__);
  [CLDEMOLog log:@"did become active" message:nil];
}

- (void)bannerAdApplicationWillResignActive:(CLGlobalBannerAd *)bannerAd error:(NSError *)error {
//  NSLog(@"%s",__FUNCTION__);
  [CLDEMOLog log:@"will resign active preview" message:nil];
}

- (void)bannerAdDidDismissPreview:(CLGlobalBannerAd *)bannerAd error:(NSError *)error {
//  NSLog(@"%s",__FUNCTION__);
  [CLDEMOLog log:@"dismiss preview" message:nil];
}

- (void)bannerAdWillShowPreview:(CLGlobalBannerAd *)bannerAd error:(NSError *)error {
//  NSLog(@"%s",__FUNCTION__);
  [CLDEMOLog log:@"will show preview" message:nil];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self configBannerAdViews];
  [self configBannerAds];
}

- (void)configBannerAdViews {
  self.title = @"BannerAd";
  self.view.backgroundColor = [UIColor whiteColor];
  [self.tableView registerNib:[UINib nibWithNibName:@"CLDEMOBannerAdContainerTableViewCell" bundle:nil] forCellReuseIdentifier:@"CLDEMOBannerAdContainerTableViewCell"];
  [self.tableView registerNib:[UINib nibWithNibName:@"CLDEMOBannerAdInvalidTableViewCell" bundle:nil] forCellReuseIdentifier:@"CLDEMOBannerAdInvalidTableViewCell"];
}

- (void)configBannerAds {
  marrBannerAds = [NSMutableArray arrayWithCapacity:2];
  for (NSInteger index = 0; index < 2; index++) {
    NSString *placementID = @"";
    switch (index) {
      case 1:
        placementID = [CLDEMOAppInfo bannerAd300_250PlacementID];
        break;
      case 0:
        placementID = [CLDEMOAppInfo bannerAd320_50PlacementID];
        break;
      default:
        break;
    }
    CLGlobalBannerAd *bannerAd =
    [[CLGlobalBannerAd alloc] initWithPlacementID:placementID];
    bannerAd.delegate = self;
    [marrBannerAds addObject:bannerAd];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 0;
}

@end
