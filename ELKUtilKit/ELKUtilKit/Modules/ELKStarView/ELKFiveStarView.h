//
//  ELKFiveStarView.h
//  ELKUtilKit
//
//  Created by Jonathan on 15/9/17.
//  Copyright (c) 2015年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELKFiveStarView : UIView

@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, strong) UIImage *foreImage;

/*
 设置显示几颗星
 */
- (void)setStarCount:(CGFloat)starCount;

/*
 初始化
 */
- (instancetype)init;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

/*
 放在xib上的视图的初始化方法是initWithCoder:
 */
- (instancetype)initWithFrame:(CGRect)frame;


@end
