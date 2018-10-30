//
//  CLGlobalBannerAd.h
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import <CentrixlinkGlobal/CentrixlinkGlobal.h>
#import <UIKit/UIKit.h>

@class CLGlobalBannerAd, CLGlobalBannerAdView;


@protocol CLGlobalBannerAdDelegate <NSObject>
@optional
/// called when banner ad load finished.
/// succeeded if error equals nil, and a non-nil bannerAdView
/// otherwise failed
- (void)bannerAdLoadFinished:(CLGlobalBannerAd *)bannerAd
                       error:(NSError *)error;
/// called when banner ad display finished, success if error is nil,
/// failed if error is non-nil
- (void)bannerAdDisplay:(CLGlobalBannerAd *)bannerAd
                  error:(NSError *)error;
/// called when banner ad impression trackings sent
- (void)bannerAdImpressionFinished:(CLGlobalBannerAd *)bannerAd
                             error:(NSError *)error;
/// called when banner ad click
- (void)bannerAdDidClick:(CLGlobalBannerAd *)bannerAd error:(NSError *)error;
/// called when banner ad will open app store or safari, or
/// deeklink app
- (void)bannerAdApplicationWillResignActive:(CLGlobalBannerAd *)bannerAd error:(NSError *)error;
/// called when user will return from other application
- (void)bannerAdApplicationDidBecomeActive:(CLGlobalBannerAd *)bannerAd error:(NSError *)error;
/// called when banner ad present StoreProductViewController
- (void)bannerAdWillShowPreview:(CLGlobalBannerAd *)bannerAd error:(NSError *)error;
/// called when banner ad dismiss StoreProductViewController
- (void)bannerAdDidDismissPreview:(CLGlobalBannerAd *)bannerAd error:(NSError *)error;
@end

/// CLGlobalBannerAd manages banner request, material loading,
/// delegate methods redirect.
///
/// <pre>
///   CLGlobalBannerAd *bannerAd = [[CLGlobalBannerAd alloc] initWithPlacementID:@""];
///   bannerAd.delegate = delegateToSet;
///   [bannerAd loadAd];
/// </pre>
@interface CLGlobalBannerAd : CLGlobalAd

@property(nonatomic, weak) id<CLGlobalBannerAdDelegate> delegate;
- (void)renderBannerAdViewInContainer:(UIView *)adContainer;
- (void)removeBannerAdViewFromContainer;
- (CGSize)bannerAdViewSize;

@end
