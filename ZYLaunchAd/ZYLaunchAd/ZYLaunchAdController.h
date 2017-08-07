//
//  ZYLaunchAdController.h
//  ZYLaunchAd
//
//  Created by mac on 17/5/1.
//  Copyright (c) 2017年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZYLaunchAdCallBackType) {
    ZYLaunchAdCallBackTypeClickAd,
    ZYLaunchAdCallBackTypeClickSkip,
    ZYLaunchAdCallBackTypeClickFinish
};

//完成后点击事件
typedef void (^ZYLaunchAdFinishHandler) (ZYLaunchAdCallBackType finishHandler);

//设置广告图片
typedef void (^ZYLaunchAdSetUpAdImageView) (UIImageView *imageView);

//设置跳过按钮以及显示时间
typedef void (^ZYLaunchAdSetupSkipBtn) (UIButton *skipBtn,  NSInteger currentTime);

@interface ZYLaunchAdController : UIViewController

@property (nonatomic, strong) UIImage *launchImage;

@property (nonatomic, strong) UIImageView *launchImageView;

@property (nonatomic, assign) CGRect adImageFrame;

@property (nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, strong) UIButton *skipButton;

@property (nonatomic, assign) NSInteger currentTime;

@property (nonatomic, copy) ZYLaunchAdSetUpAdImageView setUpAdImageView;

@property (nonatomic, copy) ZYLaunchAdFinishHandler finishHandler;

@property (nonatomic, copy) ZYLaunchAdSetupSkipBtn setUpSkipBtn;

- (instancetype)initLaunchAdWithLaunchImage:(UIImage *)launchImage setUpAdImageView:(ZYLaunchAdSetUpAdImageView)setUpAdImageView finishHandler:(ZYLaunchAdFinishHandler)finishHandler;

- (instancetype)initLaunchAdSetUpAdImageView:(ZYLaunchAdSetUpAdImageView)setUpAdImageView finishHandler:(ZYLaunchAdFinishHandler)finishHandler;

- (void)setUpSkipBtn:(ZYLaunchAdSetupSkipBtn)setUpSkipBtn;

@end
