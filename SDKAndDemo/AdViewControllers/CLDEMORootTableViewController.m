//
//  CLGlobalTableViewController.m
//  CentrixlinkDemo
//
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import "CLDEMORootTableViewController.h"
#import "CLDEMOAppInfo.h"
#import "CLDEMORootTableViewCell.h"

@interface CLDEMORootTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *tfAppID;
@property (weak, nonatomic) IBOutlet UITextField *tfAppKey;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;
@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (nonatomic, strong) NSArray   *arrTitles;
@property (nonatomic, strong) NSArray   *arrControllers;

@end

@implementation CLDEMORootTableViewController

#pragma mark - IB Action
- (IBAction)resetOfficialAppIDAndAppKey:(id)sender {
  [CLDEMOAppInfo resetOfficialTestingAppIDAndAppKey];
}

- (IBAction)updateAppIDAndAppKey:(id)sender {
  [CLDEMOAppInfo saveAppID:_tfAppID.text appKey:_tfAppKey.text];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"NSHomeDirectory = %s",
        [[NSString stringWithFormat:@"%@", NSHomeDirectory()] UTF8String]);
  [self configDEMORootViews];
  [self configDemoRootData];
}

- (void)configDEMORootViews {
  self.title = @"Centrixlink SDK";
  [self.tableView registerNib:[UINib nibWithNibName:@"CLDEMORootTableViewCell" bundle:nil] forCellReuseIdentifier:@"CLDEMORootTableViewControllerCell"];
  self.btnReset.titleLabel.numberOfLines = 0;
  self.btnUpdate.titleLabel.numberOfLines = 0;
}

- (void)configDemoRootData {
  self.arrControllers = @[
                       @"CLDEMOBannerAdTableViewController",
                       @"CLDEMONativeAdDisplayContainerTypeTableViewController",
                       @"CLDEMOInterstitialConfigTableViewController"
                       ];
  self.arrTitles = @[
                        @"BannerAd",
                        @"NativeAd",
                        @"InstertitialAd"
                        ];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.arrTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CLDEMORootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLDEMORootTableViewControllerCell" forIndexPath:indexPath];
  cell.lblTitle.text = self.arrTitles[indexPath.row];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSString *destClassString = self.arrControllers[indexPath.row];
  Class destClass = NSClassFromString(destClassString);
  UIViewController *vc = (UIViewController *)[[destClass alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Rotation
- (BOOL)shouldAutorotate {
  return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskAll;
}

@end
