//
//  CLGlobalInterstitialAd.h
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import <CentrixlinkGlobal/CentrixlinkGlobal.h>
/// a dictionary key that can be used in `showAdIn:options` method.
/// the value of it should be a boolean.
/// if true, when user back to host app after user clicks the
/// interstitial ad, the interstitial ad will be dismissed
/// false, the interstitial ad view controller will be remained
extern NSString *const CLGlobalInterstitialAdAutoCloseOptionsKey;

@class CLGlobalInterstitialAd;
@protocol CLGlobalInterstitialAdDelegate <NSObject>

@optional
/// called after instertitial ad material load succeeded.
/// called after instertitial ad material load failed.
- (void)interstitialAdDidLoad:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)loadError;
/// called after interstitial ad display succeeded.
- (void)interstitialAdDisplayFinished:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)displayError;
/// called when impresion trackings sent.
- (void)interstitialAdImpressionFinished:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)error;
/// called when interstitial ad clicked
- (void)interstitialAdDidClick:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)previewError;
/// called when close button clicked
- (void)interstitialAdDidClickClose:(CLGlobalInterstitialAd *)interstitialAd;
/// called when interstitial ad will open app store or safari, or
/// deeklink app
- (void)interstitialAdApplicationWillResignActive:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)error;
/// called when user will return from other application
- (void)interstitialAdApplicationDidBecomeActive:(CLGlobalInterstitialAd *)interstitialAd error:(NSError *)error;

@end
/// interstitial ad
/// a type of ad present a 50% black cover view in front of
/// app screen
@interface CLGlobalInterstitialAd : CLGlobalAd
/// interstitial delegate with interstitial ad callback
/// @seealso CLGlobalInterstitialAdDelegate
@property(nonatomic, weak) id<CLGlobalInterstitialAdDelegate> delegate;
/// display an interstitial ad in specific view controller with options
/// you can pass CLGlobalInterstitialAdAutoCloseOptionsKey with true to setting
/// the interstitial ad container view controller auto dismiss,
/// otherwise will be remained when user back to host app
/// @seealso CLGlobalInterstitialAdAutoCloseOptionsKey
- (void)showAdIn:(UIViewController *)viewController
         options:(NSDictionary *)options;

@end
