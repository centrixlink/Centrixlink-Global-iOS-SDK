## CentrixlinkGlobal iOS SDK Documentation

## 1. 集成SDK的前期准备
#### 1.1 
申请AppKey,AppID [Centrixlink开发者官网](http://www.centrixlink.com)
#### 1.2
创建不同广告类型的PlacementID [Centrixlink开发者官网](http://www.centrixlink.com)
#### 1.3
    iOS8+
    Xcode8+

## 2. 集成SDK
#### 2.1 通过Cocoapods安装集成
```Cocoapods
pod 'CentrixlinkGlobal', '1.0.0'
```
#### 2.2 通过下载framework手动集成
##### 2.2.1 
在Github Release中下载最新版本`CentrixlinkGlobal.framework`,将两者添加到工程中.
##### 2.2.2
在应用Target中的`General`的`Embeded Binaries`中添加    `CentrixlinkGlobal.framework`.
##### 2.2.3
在`Linked Frameworks and Libraries`中添加以下依赖:
    * UIKit.framework
    * AVFoundation.framework
    * Foundation.framework
    * CoreMedia.framework
    * CoreLocation.framework
    * CoreTelephony.framework
    * SystemConfiguration.framework  
    * Storekit.framework
    * MediaPlayer.framework
    * CFNetwork.framework
    * AdSupport.framework
    * ImageIO.framework
    * libz.dylib
    * libsqlite3.dylib
    * libstdc++.dylib
##### 2.2.4 
在应用Target中的`Build Settings`,在`Other Linker Flags`中添加`-ObjC -all_load`
#### 2.3 添加资源依赖bundle
在`Github Release`下载`CLGlobalAdBundle.bundle`文件,并添加到工程中.
_确保在`Build Phases`中的`Copy Bundle Resources`中存在`CLGlobalAdBundle.bundle`_

---
## 3. 集成广告
#### 3.1 应用启动,注册AppID, AppKey
在`AppDelegate`的`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`中添加
```Objective-C
[CLCentrixlinkGlobalADSDK startWithAppID:@"APPID" 
        appSecretKey:@"APPKEY" error:nil];
```
在[Centrixlink开发者官网](http://www.centrixlink.com)注册一个应用后,将注册生成的APPID,和APPKEY作为启动广告的参数,传入以成功启动广告SDK.

#### 3.2 SDK提供的广告类型以及集成方法
#### 3.2.1 BannerAd
##### 3.2.1.1 创建BannerAd
```Objective-C
CLGlobalBannerAd *bannerAd = [[CLGlobalBannerAd alloc] initWithPlacementID:@""];
bannerAd.delegate = self;
[bannerAd loadAd];
```
确保在`bannerAd`创建后先设置`delegate`,再调用`[bannerAd loadAd]`.
实现`CLGlobalBannerAdDelegate`的方法.
##### 3.2.1.2 BannerAd的代理方法
```Objective-C
- (void)bannerAdLoadFinished:(CLGlobalBannerAd *)bannerAd
                       error:(NSError *)error;
```
`bannerAd`加载结束,如果`error`为`nil`,加载成功.开发者可以使用`- (void)renderBannerAdViewInContainer:(UIView *)adContainer;`来将`bannerAd`渲染到开发者提供的容器视图上.
如果`error`不为`nil`,加载失败.
<br />
```Objective-C
- (void)bannerAdDisplay:(CLGlobalBannerAd *)bannerAd
                  error:(NSError *)error;
```
`bannerAd`显示完成,如果`error`为`nil`,显示成功.如果`error`不为`nil`,显示失败.
<br />
```Objective-C
- (void)bannerAdImpressionFinished:(CLGlobalBannerAd *)bannerAd
                             error:(NSError *)error;
```
`bannerAd`根据SDK产品逻辑曝光回调.如果`error`为`nil`,曝光成功.如果`error`不为`nil`,曝光失败.
<br />
```Objective-C
- (void)bannerAdDidClick:(CLGlobalBannerAd *)bannerAd 
                   error:(NSError *)error;
```
点击`bannerView`后跳转`landingpage`的回调.如果`error`为`nil`,跳转成功.如果`error`不为`nil`,跳转失败.
<br />
```Objective-C
- (void)bannerAdApplicationDidBecomeActive:(CLGlobalBannerAd *)bannerAd 
                                     error:(NSError *)error
```
点击`bannerView`后跳出当前应用的回调
<br />
```Objective-C
- (void)bannerAdApplicationWillResignActive:(CLGlobalBannerAd *)bannerAd 
                                      error:(NSError *)error
```
点击`bannerView`后,再回到当前应用的回调
<br />
```Objective-C
- (void)bannerAdWillShowPreview:(CLGlobalBannerAd *)bannerAd 
                          error:(NSError *)error
```
点击`bannerView`弹出应用内`SKStoreProductViewController`回调
```Objective-C
- (void)bannerAdDidDismissPreview:(CLGlobalBannerAd *)bannerAd 
                            error:(NSError *)error
```
`SKStoreProductViewController`显示消失的回调

#### 3.2.2 NativeAd
NativeAd一共有四种高度的模板,分别为100,120,330,400.如果开发者提供的渲染NativeAd的容器尺寸不符合四种模板的最小尺寸,则会有渲染错误,并给开发者提供回调.
#### 样式
|类型|图示|
|--|--|
|NativeAd100|![NativeAd100](./DocImages/100dp.png)|
|NativeAd120|![NativeAd120](./DocImages/120dp.png)|
|NativeAd330|![NativeAd330](./DocImages/330dp.png)|
|NativeAd400|![NativeAd400](./DocImages/400dp.png)|
##### 3.2.2.1 创建NativeAd
```Objective-C
CLGlobalNativeAd *nativeAd = [[CLGlobalNativeAd alloc]  
            initWithPlacementID:@"" displayWidth:320];
nativeAd.delegate = self;
[nativeAd loadAd];
```
根据`CLGlobalNativeAd`的初始化方法来创建一个`nativeAd`
##### 3.2.2.2 NativeAd的代理方法
```Objective-C
- (void)nativeAdLoadFinished:(CLGlobalNativeAd *)nativeAd
                       error:(NSError *)loadError;
```
`nativeAd`加载结束,如果`error`为`nil`,加载成功.开发者可以通过`- (void)renderNativeAdViewInContainer:(UIView *)adSuperView;`来将`nativeAd`渲染到开发者的容器视图中.
如果`error`不为`nil`,加载失败.
<br />
```Objective-C
- (void)nativeAdImpressionFinished:(CLGlobalNativeAd *)nativeAd
                             error:(NSError *)error;
```
bannerAd根据SDK产品逻辑曝光回调.如果`error`为`nil`,曝光成功.如果`error`不为`nil`,曝光失败.
<br />
```Objective-C
- (void)nativeAdDidClickCTA:(CLGlobalNativeAd *)nativeAd
                      error:(NSError *)error;
```
点击`nativeAdView`后跳转`landingpage`的回调.如果`error`为`nil`,跳转`landingPage`成功.如果`error`不为`nil`,跳转失败.
<br />
```Objective-C
- (void)nativeAdApplicationDidBecomeActive:(CLGlobalNativeAd *)nativeAd 
                                     error:(NSError *)error
```
点击`nativeAdView`后跳出当前应用的回调
<br />
```Objective-C
- (void)nativeAdApplicationWillResignActive:(CLGlobalNativeAd *)nativeAd 
                                      error:(NSError *)error
```
点击`nativeAdView`后,再回到当前应用的回调
<br />

```Objective-C
- (void)nativeAdWillShowPreview:(CLGlobalNativeAd *)nativeAd 
                          error:(NSError *)error
```
点击`nativeAdView`弹出应用内`SKStoreProductViewController`回调
<br />
```Objective-C
- (void)nativeAdDidDismissPreview:(CLGlobalNativeAd *)nativeAd 
                            error:(NSError *)error
```
`SKStoreProductViewController`显示消失的回调

#### 3.2.3 InterstitialAd
##### 3.2.3.1 创建InterstitialAd
```Objective-C
CLGlobalInterstitialAd *interstitialAd = [[CLGlobalInterstitialAd alloc] initWithPlacementID:@""];
interstitialAd.delegate = self;
[interstitialAd loadAd];
```
根据`CLGlobalInterstitialAd`的初始化方法来创建一个`nativeAd`.
##### 3.2.3.2 InterstitialAd的代理方法
```Objective-C
- (void)interstitialAdDidLoad:(CLGlobalInterstitialAd *)interstitialAd 
                        error:(NSError *)loadError;
```
`interstitialAd`加载结束.如果`error`为`nil`,则加载成功,开发者可以调用`- (void)showAdIn:(UIViewController *)viewController
         options:(NSDictionary *)options`来显示此次加载成功的`interstitialAd`.
如果`error`不为`nil`,加载失败.
<br />
```Objective-C
- (void)interstitialAdDisplayFinished:(CLGlobalInterstitialAd *)interstitialAd
                                error:(NSError *)error;
```
如果`error`为`nil`,展示成功.开发者通过调用`- (void)showAdIn:(UIViewController *)viewController options:(NSDictionary *)options`来显示`interstitialAd`的弹出窗口.
如果`error`不为`nil`,展示失败.
<br /> 
```Objective-C
- (void)interstitialAdImpressionFinished:(CLGlobalInterstitialAd *)interstitialAd
                                   error:(NSError *)error;
```
`interstitialAd`曝光的回调.如果`error`为`nil`,曝光成功.如果`error`不为`nil`,曝光失败.
<br />
```Objective-C
- (void)interstitialAdDidClick:(CLGlobalInterstitialAd *)interstitialAd 
                         error:(NSError *)previewError;
```
点击`interstitialAd`广告的回调.如果`error`为`nil`,点击跳转`landingPage`成功.如果`error`不为`nil`,点击跳转`landingPage`失败.
<br />
```Objective-C
- (void)interstitialAdDidClickClose:(CLGlobalInterstitialAd *)interstitialAd;
```
点击`interstitialAd`关闭按钮的回调,以及自动关闭`interstitialAd`的回调
<br />
```Objective-C
- (void)interstitialAdApplicationDidBecomeActive:(CLGlobalInterstitialAd *)interstitialAd 
                                           error:(NSError *)error
```
点击`interstitialAd`后跳出当前应用的回调
<br />
```Objective-C
- (void)interstitialAdApplicationWillResignActive:(CLGlobalInterstitialAd *)interstitialAd 
                                            error:(NSError *)error
```
点击`nativeAdView`后,再回到当前应用的回调

---
## 4. Error信息
#### ErrorDomain 为com.centrlixlink.sdk.ios.global.error

|errorCode|info|
|--|--|
|1000, 1001, 1002 |SDK启动错误|
|1500|不合规URL|
|1550|不合规JSON|
|1600,1601|文件操作错误|
|1650|http返回状态码错误|
|1700|langding page无法打开|
|1750|操作取消|
|1800|图片下载错误|
|1900|placementID错误|
|3000, 3001, 3002, 3003, 3004|nativeAd数据返回错误|
|3100|开发者提供渲染nativeAd视图的容器尺寸不合规,不同类型nativeAd,所需容器最小宽度不同.|
|4000, 4001, 4002, 4003, 4004, 4005|bannerAd数据返回错误|
|4100|开发者提供渲染bannerAd视图的容器尺寸不合规,bannerAd所需渲染容器宽高需要大于等于广告位尺寸|
|5000, 5001, 5002, 5003, 5004|interstitialAd数据返回错误|

## 5.联系我们
mail: [Jiawei](mailto:jiawei.xu@centrixlink.com)