//
//  CLSDKStreamLogHeader.h

//

//  Copyright © 2018 Centrixlink. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CLGlobalAdLogLevel) {
  CLGlobalAdLogLevelError,
  CLGlobalAdLogLevelWarning,
  CLGlobalAdLogLevelInformation,
  CLGlobalAdLogLevelDebug
};

typedef void (^CLGlobalAdDebugCallBack)(NSString *message,
                                        CLGlobalAdLogLevel level);
