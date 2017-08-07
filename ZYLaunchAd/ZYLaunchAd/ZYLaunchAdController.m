//
//  ZYLaunchAdController.m
//  ZYLaunchAd
//
//  Created by mac on 17/5/1.
//  Copyright (c) 2017年 zy. All rights reserved.
//

#import "ZYLaunchAdController.h"

#define MAINWIDTH [UIScreen mainScreen].bounds.size.width
#define MAINHEIGHT [UIScreen mainScreen].bounds.size.height
#define MARGIN 20

@interface ZYLaunchAdController ()
{
    BOOL _isBegin;
}

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZYLaunchAdController

//懒加载
- (UIImageView *)launchImageView {
    if (!_launchImageView) {
        _launchImageView = [UIImageView new];
        _launchImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _launchImageView;
}

- (UIImageView *)adImageView {
    if (!_adImageView) {
        _adImageView = [UIImageView new];
        _adImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _adImageView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton new];
        _skipButton.layer.masksToBounds = YES;
        _skipButton.layer.cornerRadius = 10.f;
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipButton setBackgroundColor:[UIColor blackColor]];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [_skipButton addTarget:self action:@selector(skipButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (instancetype)initLaunchAdWithLaunchImage:(UIImage *)launchImage setUpAdImageView:(ZYLaunchAdSetUpAdImageView)setUpAdImageView finishHandler:(ZYLaunchAdFinishHandler)finishHandler {
    if (self == [super initWithNibName:nil bundle:nil]) {
        _launchImage = launchImage;
        _setUpAdImageView = [setUpAdImageView copy];
        _finishHandler = [finishHandler copy];
        if (_launchImage) {
            _adImageFrame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT *(2 / 3));
        } else {
            _adImageFrame = CGRectMake(0, 0, MAINWIDTH, MAINHEIGHT);
        }
        setUpAdImageView(self.adImageView);
        self.currentTime = 5.f;
    }
    return self;
}

- (instancetype)initLaunchAdSetUpAdImageView:(ZYLaunchAdSetUpAdImageView)setUpAdImageView finishHandler:(ZYLaunchAdFinishHandler)finishHandler {
    return [self initLaunchAdWithLaunchImage:nil setUpAdImageView:setUpAdImageView finishHandler:finishHandler];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    if (_launchImage) {
        self.launchImageView.frame = self.view.bounds;
    }
    self.adImageView.frame = _adImageFrame;
    [self.skipButton sizeToFit];
    CGRect skipBtnFrame = self.skipButton.bounds;
    CGFloat skipBtnW = skipBtnFrame.size.width + MARGIN;
    CGFloat skipBtnH = skipBtnFrame.size.height;
    CGFloat skipBtnX = MAINWIDTH - skipBtnFrame.size.width - 30;
    CGFloat skipBtnY = MARGIN;
    skipBtnFrame = CGRectMake(skipBtnX, skipBtnY, skipBtnW, skipBtnH);
    self.skipButton.frame = skipBtnFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGR =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tapGR.numberOfTapsRequired = 1;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tapGR];
    if (_launchImage) {
        _launchImageView.image = self.launchImage;
        [self.view addSubview:self.launchImageView];
    }
    [self.view addSubview:self.adImageView];
    [self.view addSubview:self.skipButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //添加定时器
    [self addTimer];
    [self startTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)dealloc {
    [self stopTimer];
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)startTimer {
    if (self.timer) {
        [self.timer fire];
    }
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timerHandler {
    if (!_isBegin) {
        _isBegin = YES;
        return;
    }
    self.currentTime --;
    if ((_currentTime == 0) && _finishHandler) {
        [self stopTimer];
        if (_finishHandler) {
            _finishHandler(ZYLaunchAdCallBackTypeClickFinish);
        }
    }
}

- (void)skipButtonDidClick:(UIButton *)button {
    if (_finishHandler) {
        _finishHandler(ZYLaunchAdCallBackTypeClickSkip);
    }
}

- (void)tapHandler:(UITapGestureRecognizer *)tapGR {
    if (_finishHandler) {
        _finishHandler(ZYLaunchAdCallBackTypeClickAd);
    }
}

- (void)setAdImageFrame:(CGRect)adImageFrame {
    _adImageFrame = adImageFrame;
    [self.view setNeedsLayout];
}

- (void)setUpSkipBtn:(ZYLaunchAdSetupSkipBtn)setUpSkipBtn {
    _setUpSkipBtn = [setUpSkipBtn copy];
}

- (void)setCurrentTime:(NSInteger)currentTime {
    _currentTime = currentTime;
    if (_currentTime) {
        if (_setUpSkipBtn) {
            _setUpSkipBtn(self.skipButton, currentTime);
        }
    } else {
        [self.skipButton setTitle:[NSString stringWithFormat:@"%lds 跳过",(long)currentTime] forState:UIControlStateNormal];
    }
    if (!_isBegin) {
       [self.view setNeedsLayout];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
