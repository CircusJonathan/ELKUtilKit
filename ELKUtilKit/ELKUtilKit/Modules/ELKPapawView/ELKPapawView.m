//
//  ELKPapawView.h
//  ELKUtilKit
//
//  Created by wing on 2018/4/26.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "ELKPapawView.h"
#import "ELKUtilDefinesHeader.h"
#import "ELKUtilQuant.h"


static CGFloat ELK_papawViewWidth = 100.f;
static CGFloat ELK_papawViewMinY  = 130.f;

@interface ELKPapawView()

@property (nonatomic, strong) UIView *papView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSTimer *papawTimer;

@property (nonatomic, assign) BOOL hiddenPapaw;
@property (nonatomic, assign) BOOL papawDirect;// NO:left YES:right

@property (nonatomic, copy) ELKPapawTapBlock papawTapBlock;

@end


@implementation ELKPapawView

+ (instancetype)sharedPapawView
{
    static ELKPapawView *elkPapView = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        elkPapView = [[ELKPapawView alloc] init];
    });
    return elkPapView;
}

+ (void)showPapawView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ELKPapawView *elkPapView = [ELKPapawView sharedPapawView];
        [[UIApplication sharedApplication].keyWindow addSubview:elkPapView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:elkPapView];
        [elkPapView configPapawTimer];
    });
    
}

+ (void)refreshPapawViewWithNum:(NSInteger)number block:(ELKPapawTapBlock)block
{
    if (number > 0) {
        [ELKPapawView sharedPapawView].titleLabel.text = [NSString stringWithFormat:@"%ld", (long)number];
        [ELKPapawView sharedPapawView].papawTapBlock = block;
        [ELKPapawView showPapawView];
    } else {
        [ELKPapawView sharedPapawView].titleLabel.text = @"0";
        [ELKPapawView sharedPapawView].papawTapBlock = block;
        [ELKPapawView dismissPapawView];
    }
    
}

+ (void)dismissPapawView
{
    [[ELKPapawView sharedPapawView] removeFromSuperview];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.papawDirect = YES;
        self.frame = CGRectMake(ELKUtilScreenWidth - ELK_papawViewWidth - 10.f, ELK_papawViewMinY, ELK_papawViewWidth, ELK_papawViewWidth);
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = ELK_papawViewWidth / 2.f;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.papView];
        [self addSubview:self.backImageView];
        [self addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(0.f, 0.f, ELK_papawViewWidth, ELK_papawViewWidth);
        
        self.hiddenPapaw = NO;
    }
    return self;
}

- (UIView *)papView
{
    return _papView ?: ({
        _papView = [[UIView alloc] initWithFrame:self.bounds];
        _papView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [_papView addGestureRecognizer:tapGesture];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [_papView addGestureRecognizer:panGesture];
//        [tapGesture requireGestureRecognizerToFail:panGesture];
        
        _papView;
    });
}

- (UIImageView *)backImageView
{
    return _backImageView ?: ({
        _backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backImageView.image = [UIImage elk_imageNamed:@"ELKPapawView/elk_papawview_back"];
        _backImageView;
    });
}

- (UILabel *)titleLabel
{
    return _titleLabel ?: ({
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = ELK_UtilHexColor(0x333333, 1.f);
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel;
    });
}

// tap Gesture
- (void)tapGestureAction:(UIGestureRecognizer *)tapGesture
{
    if (self.hiddenPapaw) {
        [self horizonMovePapawView];
    } else {
        [self configPapawTimer];
        if (self.papawTapBlock) {
            self.papawTapBlock();
        }
    }
    
}
// pan Gesture
- (void)panGestureAction:(UIGestureRecognizer *)panGesture
{
    CGPoint panPoint = [panGesture locationInView:[UIApplication sharedApplication].keyWindow];
    self.hiddenPapaw = NO;
    self.alpha = 1.f;
    self.center = panPoint;
    ELK_papawViewMinY = panPoint.y - ELK_papawViewWidth / 2.f;
    if (ELK_papawViewMinY <= ELK_safeTop(NO)) {
        ELK_papawViewMinY = ELK_safeTop(NO);
    } else if (ELK_papawViewMinY >= ELKUtilScreenHeight - ELK_papawViewWidth - ELK_safeBottom()) {
        ELK_papawViewMinY = ELKUtilScreenHeight - ELK_papawViewWidth - ELK_safeBottom();
    }
    if (panPoint.x > ELKUtilScreenWidth / 2.f) {
        self.papawDirect = YES;
    } else {
        self.papawDirect = NO;
    }
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        [self configPapawTimer];
        [UIView animateWithDuration:0.15f animations:^{
            CGFloat papVX = 10.f;
            if (self.papawDirect) {
                papVX = ELKUtilScreenWidth - ELK_papawViewWidth - 10.f;
            }
            self.frame = CGRectMake(papVX, ELK_papawViewMinY, ELK_papawViewWidth, ELK_papawViewWidth);
        }];
    }
    
}

- (void)configPapawTimer
{
    [self.papawTimer invalidate];
    if (@available(iOS 10.0, *)) {
        self.papawTimer = [NSTimer scheduledTimerWithTimeInterval:5.f repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self papawTimerAction];
        }];
    } else {
        self.papawTimer = [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(papawTimerAction) userInfo:nil repeats:NO];
    }
}

- (void)papawTimerAction
{
    self.hiddenPapaw = YES;
    [self.papawTimer invalidate];
    [UIView animateWithDuration:0.35f animations:^{
        CGFloat papVX = -ELK_papawViewWidth / 2.f;
        if (self.papawDirect) {
            papVX = ELKUtilScreenWidth - ELK_papawViewWidth / 2.f;
        }
        self.frame = CGRectMake(papVX, ELK_papawViewMinY, ELK_papawViewWidth, ELK_papawViewWidth);
        self.alpha = 0.35f;
    }];
    
}

- (void)horizonMovePapawView
{
    self.hiddenPapaw = NO;
    [self configPapawTimer];
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1.f;
        CGFloat papVX = 10.f;
        if (self.papawDirect) {
            papVX = ELKUtilScreenWidth - ELK_papawViewWidth - 10.f;
        }
        self.frame = CGRectMake(papVX, ELK_papawViewMinY, ELK_papawViewWidth, ELK_papawViewWidth);
    } completion:^(BOOL finished) {
        
    }];
    
}


@end

