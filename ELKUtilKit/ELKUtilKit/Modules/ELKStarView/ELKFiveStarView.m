//
//  ELKFiveStarView.m
//  ELKUtilKit
//
//  Created by Jonathan on 15/9/17.
//  Copyright (c) 2015年 wing. All rights reserved.
//

#import "ELKFiveStarView.h"

@implementation ELKFiveStarView
{
    UIImageView *_backgroundImageView;//背景的灰星星
    UIImageView *_foregroundImageView;//前景的红星星
}

// 直接初始化
- (instancetype)init{
    if (self = [super init]) {
        [self loadImage];
    }
    return self;
}

// 直接创建的时候初始化方法为initWithFrame:
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadImage];
    }
    return self;
}

// 注意：放在xib上的视图的初始化方法是initWithCoder:
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadImage];
    }
    return self;
}

// 加载Star
- (void)loadImage
{
    // 加载背景图
    UIImage *backgroundImage = [UIImage imageNamed:@"StarsBackground"];
    _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height)];
    _backgroundImageView.image = backgroundImage;
    [self addSubview:_backgroundImageView];
    // 加载前景图
    UIImage *foregroundImage = [UIImage imageNamed:@"StarsForeground"];
    _foregroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, foregroundImage.size.width, foregroundImage.size.height)];
    // 不自动缩放，如果imageView比image小，只显示左边
    _foregroundImageView.contentMode = UIViewContentModeLeft;
    // 当要显示的内容超过imageView的大小时，把超出部分截掉
    _foregroundImageView.clipsToBounds = YES;
    _foregroundImageView.image = foregroundImage;
    [self addSubview:_foregroundImageView];
    self.backgroundColor = [UIColor clearColor];
}

// 设置显示几颗星
- (void)setStarCount:(CGFloat)starCount
{
    CGFloat width = _backgroundImageView.frame.size.width*starCount/5;
    _foregroundImageView.frame = CGRectMake(0, 0, width, _foregroundImageView.frame.size.height);
}


@end
