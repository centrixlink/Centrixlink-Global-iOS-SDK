//
//  CLCentrixlinkGlobalADSDK.h
//  Centrixlink
//
//  Copyright © 2016年 Centrixlink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CentrixlinkGlobal/CLGlobalAdLogHeader.h>

@class UIViewController;

@interface CLCentrixlinkGlobalADSDK : NSObject
/**
 start sdk
 @param appID generated from platform
 @param appSecretKey generated from platform
 @param error this error will not be nil if something
        wrong happend when sdk startup
 @return YES start up successfully, otherwise NO
 */
+ (BOOL)startWithAppID:(NSString *)appID
          appSecretKey:(NSString *)appSecretKey
                 error:(NSError *__autoreleasing *)error;

/**
 SDK version number for current release
 @return SDK version number
 */
+ (NSString *)SDKVersion;

#pragma mark - DEBUG Section
/**
 enable debug log or disable debug log
 @param enable YES to enable, NO to disable
 */
+ (void)setDebugEnable:(BOOL)enable;
/**
 debug log callback
 @param callBack debug log callback
 */
+ (void)setDebugCallBack:(CLGlobalAdDebugCallBack)callBack;

@end


