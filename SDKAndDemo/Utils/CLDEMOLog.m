//
//  CLDEMOAlert.m
//  SDKAndDemo
//
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import "CLDEMOLog.h"
#import <UIKit/UIKit.h>

@interface CLDEMOLog ()<UIAlertViewDelegate>

@end

@implementation CLDEMOLog

+ (void)log:(NSString *)title message:(NSString *)msg {
  NSLog(@"[DEMO_LOG] title: %@ message: %@", title, msg);
}

@end
