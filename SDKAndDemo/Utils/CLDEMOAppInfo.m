//
//  CLDEMOAppInfo.m
//  SDKAndDemo
//
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import "CLDEMOAppInfo.h"

static NSString *CLDEMOAppID = @"5bd034c2380000e9496398ac";
static NSString *CLDEMOAppKey = @"97e0db8d830c96b5876687ad351fc8848ef7861bff46ba6f7e1adbfa7f7e84e6";

static NSString *CLDEMOAppIDUserDefaultKey = @"CLDEMOAppIDUserDefaultKey";
static NSString *CLDEMOAppKeyUserDefaultKey = @"CLDEMOAppKeyUserDefaultKey";

static NSString *CLDEMOBannerAd320_50PlacementID = @"5b86137b28eb3a70ce5e7fcc";
static NSString *CLDEMOBannerAd300_250PlacementID = @"5bb2e26de30000ed0111d22a";
static NSString *CLDEMOBannerAdUserDefaultKey = @"CLDEMOBannerAdUserDefaultKey";

static NSString *CLDEMONativeAdUserDefaultKey = @"CLDEMONativeAdUserDefaultKey";

static NSString *CLDEMOInterstitialAdPlacmentID = @"5bbc7a32530000fe2229b384";
static NSString *CLDEMOInterstitialAdUserDefaultKey = @"CLDEMOInterstitialAdUserDefaultKey";

@implementation CLDEMOAppInfo

+ (NSString *)appID {
  NSString *appID = [[NSUserDefaults standardUserDefaults] stringForKey:CLDEMOAppIDUserDefaultKey];
  if (appID.length) {
    return appID;
  }
  return CLDEMOAppID;
}

+ (NSString *)appKey {
  NSString *appKey = [[NSUserDefaults standardUserDefaults] stringForKey:CLDEMOAppKeyUserDefaultKey];
  if (appKey.length) {
    return appKey;
  }
  return CLDEMOAppKey;
}

+ (void)saveAppID:(NSString *)appID appKey:(NSString *)appKey {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  [ud setObject:appID forKey:CLDEMOAppIDUserDefaultKey];
  [ud setObject:appKey forKey:CLDEMOAppKeyUserDefaultKey];
  [ud synchronize];
}

+ (void)resetOfficialTestingAppIDAndAppKey {
  [self saveAppID:CLDEMOAppID appKey:CLDEMOAppKey];
}

+ (NSString *)bannerAd320_50PlacementID {
  NSString *bannerAdPlacementID = [[NSUserDefaults standardUserDefaults] stringForKey:CLDEMOBannerAdUserDefaultKey];
  if (bannerAdPlacementID.length) {
    return bannerAdPlacementID;
  }
  return CLDEMOBannerAd320_50PlacementID;
}

+ (NSString *)bannerAd300_250PlacementID {
  return CLDEMOBannerAd300_250PlacementID;
}

+ (void)saveBannerAdPlacementID:(NSString *)bannerAdPlacementID {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  [ud setObject:bannerAdPlacementID forKey:CLDEMOBannerAdUserDefaultKey];
  [ud synchronize];
}

+ (NSArray *)nativeAdPlacementIDs {
  NSArray *nativeAdPlacementIDs = [[NSUserDefaults standardUserDefaults] arrayForKey:CLDEMONativeAdUserDefaultKey];
  if (nativeAdPlacementIDs.count) {
    return nativeAdPlacementIDs;
  }
  return @[
           @"5b8613b428eb3a70ce5e8030",
           @"5b8613c328eb3a70ce5e86a4",
           @"5b8613d528eb3a70ce5eb095",
           @"5b8613e528eb3a70ce5eb8ee"
           ];
}

+ (void)saveNativeAdPlacementIDs:(NSString *)nativeAdPlacementIDs {
  NSArray *arrNativeAdPlacementIDs = [nativeAdPlacementIDs componentsSeparatedByString:@","];
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  [ud setObject:arrNativeAdPlacementIDs forKey:CLDEMONativeAdUserDefaultKey];
  [ud synchronize];
}

+ (NSString *)interstitialAdPlacementID {
  NSString *interstitialAdPlacementID = [[NSUserDefaults standardUserDefaults] stringForKey:CLDEMOInterstitialAdUserDefaultKey];
  if (interstitialAdPlacementID.length) {
    return interstitialAdPlacementID;
  }
  return CLDEMOInterstitialAdPlacmentID;
}

+ (void)saveInterstitialAdPlacementID:(NSString *)interstitialPlacementID {
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  [ud setObject:interstitialPlacementID forKey:CLDEMOInterstitialAdUserDefaultKey];
  [ud synchronize];
}

@end
