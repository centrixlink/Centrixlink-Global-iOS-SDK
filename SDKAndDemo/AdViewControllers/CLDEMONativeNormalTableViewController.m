//
//  CLDEMONativeNormalTableViewController.m
//  SDKAndDemo
//
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import "CLDEMONativeNormalTableViewController.h"
#import "CLDEMOLog.h"
#import <Masonry.h>
#import <CentrixlinkGlobal/CentrixlinkGlobal.h>

@interface CLDEMONativeNormalTableViewController ()<CLGlobalNativeAdDelegate> {
  CLGlobalNativeAd  *nativeAd;
  UIView *configView;
}

@property (strong, nonatomic) IBOutlet UIView *vHeaderView;

@end

@implementation CLDEMONativeNormalTableViewController

- (IBAction)loadNativeAd:(id)sender {
  [nativeAd loadAd];
}

- (IBAction)showNativeAd:(id)sender {
  [nativeAd renderNativeAdViewInContainer:_vHeaderView];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Native Ad";
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 400)];
  self.vHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"CLDEMONativeOnNormalContainerView" owner:self options:nil] lastObject];
  [headerView addSubview:self.vHeaderView];
  [self.vHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(headerView);
  }];
  self.tableView.tableHeaderView = headerView;
  
  nativeAd = [[CLGlobalNativeAd alloc] initWithPlacementID:@"5b8613e528eb3a70ce5eb8ee"];
  nativeAd.delegate = self;
  [nativeAd loadAd];
  // Do any additional setup after loading the view from its nib.
}

- (NSString *)sectionHeaderNibName {
  return @"CLDEMONativeOnNormalLoadView";
}

- (CGFloat)tableViewSectionHeaderHeight {
  return 100;
}

- (void)nativeAdLoadFinished:(CLGlobalNativeAd *)nativeAd
                       error:(NSError *)loadError {
  if (loadError) {
    [CLDEMOLog log:@"load error" message:nil];
  }
}
/// called when native ad display finished, no error succecceded,
/// otherwise non-nil error
- (void)nativeAdDisplayFinished:(CLGlobalNativeAd *)nativeAd
                          error:(NSError *)error {
  if (error) {
    [CLDEMOLog log:@"display error" message:nil];
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

- (void)nativeAdApplicationDidBecomeActive:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  NSLog(@"%s",__FUNCTION__);
}

- (void)nativeAdApplicationWillResignActive:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  NSLog(@"%s",__FUNCTION__);
}

- (void)nativeAdDidDismissPreview:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  NSLog(@"%s",__FUNCTION__);
}

- (void)nativeAdWillShowPreview:(CLGlobalNativeAd *)nativeAd error:(NSError *)error {
  NSLog(@"%s",__FUNCTION__);
}


@end
