//
//  CLGlobalAd.h
//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CLGlobalAd : NSObject
/// ad placementID. create from official website.
@property (nonatomic, copy, readonly) NSString  *placementID;
/// ad designated initializer
- (instancetype)initWithPlacementID:(NSString *)placementID NS_DESIGNATED_INITIALIZER;
/// load ad, you should set delegate before call this method.
- (void)loadAd;

@end
