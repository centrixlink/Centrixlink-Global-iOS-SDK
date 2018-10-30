//
//  CLDEMOInterstitialTableViewController.m
//  SDKAndDemo
//
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import "CLDEMOInterstitialTableViewController.h"
#import <CentrixlinkGlobal/CentrixlinkGlobal.h>
#import "CLDEMOAppInfo.h"
#import "CLDEMOLog.h"
#import <Masonry/Masonry.h>
#import "CLDEMOInterstitialConfig.h"

@interface CLDEMOInterstitialTableViewController ()<CLGlobalInterstitialAdDelegate> {
  UIView *configView;
}

@property (nonatomic, strong) CLGlobalInterstitialAd *interstitialAd;

@end

@implementation CLDEMOInterstitialTableViewController

#pragma mark - Life Cycle
- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  NSLog(@"interstitial ad did disappear");
}

- (IBAction)loadAd:(id)sender {
  [self.interstitialAd loadAd];
}

- (IBAction)showAd:(id)sender {
  [self.interstitialAd showAdIn:self options:@{CLGlobalInterstitialAdAutoCloseOptionsKey : @([self.config shouldAutoCloseAd])}];
}

- (IBAction)backToConfig:(UIButton *)bbi {
  [self dismissViewControllerAnimated:YES completion:^{
    
  }];
}

- (CGFloat)tableViewSectionHeaderHeight {
  return 300;
}

- (NSString *)sectionHeaderNibName {
  return @"CLDEMOInterstitialAdDisplayView";
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"Display InstertitialAd";
  self.interstitialAd = [[CLGlobalInterstitialAd alloc] initWithPlacementID:[CLDEMOAppInfo interstitialAdPlacementID]];
  self.interstitialAd.delegate = self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Interstitial Delegate
- (void)interstitialAdDidLoad:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)loadError {
  if (loadError) {
    [CLDEMOLog log:@"load error" message:nil];
  }
}

/// called after interstitial ad display succeeded.
- (void)interstitialAdDisplayFinished:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)displayError {
  if (displayError) {
    [CLDEMOLog log:@"display error" message:nil];
  } else {
    [CLDEMOLog log:@"display interstitial" message:nil];
  }
}
/// called when impresion trackings sent.
- (void)interstitialAdImpressionFinished:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)error {
  
}

/// called when interstitial ad clicked
- (void)interstitialAdDidClick:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)previewError {
  
}
/// called when close button clicked
- (void)interstitialAdDidClickClose:(CLGlobalInterstitialAd *)interstitialAd {
  [CLDEMOLog log:@"dismiss interstitial" message:nil];
}

- (void)interstitialAdApplicationDidBecomeActive:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)error {
  [CLDEMOLog log:@"did become active" message:nil];
}

- (void)interstitialAdApplicationWillResignActive:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)error {
  [CLDEMOLog log:@"will resign active" message:nil];
}
    

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return 0;
}

- (BOOL)shouldAutorotate {
  return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return self.config.interfaceMask;
}

@end
