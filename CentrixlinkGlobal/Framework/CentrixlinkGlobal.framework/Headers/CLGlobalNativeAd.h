//
//  CLGlobalNativeAd.h
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import <CentrixlinkGlobal/CentrixlinkGlobal.h>
#import <UIKit/UIKit.h>

@class CLGlobalNativeAd, CLGlobalNativeAdView;

@protocol CLGlobalNativeAdDelegate <NSObject>
@optional
/// called when native ad load finished, if succeded,
/// with nil loadError, otherwise, nil nativeAdView and non-nil loadError
- (void)nativeAdLoadFinished:(CLGlobalNativeAd *)nativeAd
                       error:(NSError *)loadError;
/// called when native ad display finished, no error succecceded,
/// otherwise non-nil error
- (void)nativeAdDisplayFinished:(CLGlobalNativeAd *)nativeAd
                          error:(NSError *)error;
// called when native ad impression trackings sent
- (void)nativeAdImpressionFinished:(CLGlobalNativeAd *)nativeAd
                             error:(NSError *)error;
/// succeded if error equals nil
- (void)nativeAdDidClickCTA:(CLGlobalNativeAd *)nativeAd
                      error:(NSError *)error;
/// called when native ad will open app store or safari, or
/// deeklink app
- (void)nativeAdApplicationWillResignActive:(CLGlobalNativeAd *)nativeAd error:(NSError *)error;
/// called when user will return from other application
- (void)nativeAdApplicationDidBecomeActive:(CLGlobalNativeAd *)nativeAd error:(NSError *)error;
/// called when native ad present StoreProductViewController
- (void)nativeAdWillShowPreview:(CLGlobalNativeAd *)nativeAd error:(NSError *)error;
/// called when native ad dismiss StoreProductViewController
- (void)nativeAdDidDismissPreview:(CLGlobalNativeAd *)nativeAd error:(NSError *)error;
@end

@interface CLGlobalNativeAd : CLGlobalAd
/// native ad delegate
@property(nonatomic, weak) id<CLGlobalNativeAdDelegate> delegate;

/// render ad view in superview, ad view will fill this super view
- (void)renderNativeAdViewInContainer:(UIView *)adSuperView;
- (void)removeNativeAdViewFromContainer;
- (CGFloat)nativeAdViewHeight;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;
@end
