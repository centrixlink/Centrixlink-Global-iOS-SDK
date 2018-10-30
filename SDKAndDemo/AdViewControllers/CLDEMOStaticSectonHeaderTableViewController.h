//
//  StaticSectonHeaderTableViewController.h
//  SDKAndDemo
//
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLDEMOStaticSectonHeaderTableViewController : UITableViewController

- (NSString *)sectionHeaderNibName;
- (UIView *)staticSectionHeader;
- (CGFloat)tableViewSectionHeaderHeight;

@end
