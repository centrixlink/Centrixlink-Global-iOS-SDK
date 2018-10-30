//
//  CLDEMOAppInfo.h
//  SDKAndDemo
//
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLDEMOAppInfo : NSObject

+ (NSString *)appID;
+ (NSString *)appKey;

+ (void)saveAppID:(NSString *)appID appKey:(NSString *)appKey;
+ (void)resetOfficialTestingAppIDAndAppKey;

+ (NSString *)bannerAd320_50PlacementID;
+ (NSString *)bannerAd300_250PlacementID;
+ (void)saveBannerAdPlacementID:(NSString *)bannerAdPlacementID;

+ (NSArray *)nativeAdPlacementIDs;
+ (void)saveNativeAdPlacementIDs:(NSString *)nativeAdPlacementIDs;

+ (NSString *)interstitialAdPlacementID;
+ (void)saveInterstitialAdPlacementID:(NSString *)interstitialPlacementID;

@end


