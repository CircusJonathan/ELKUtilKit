//
//  ELKNoDataView.m
//  ELKUtilKit
//
//  Created by wing on 2017/12/6.
//  Copyright © 2017年 wing. All rights reserved.
//

#import "ELKNoDataView.h"
#import "ELKUtilDefinesHeader.h"
#import "ELKUtilQuant.h"


@interface ELKNoDataView ()

@property (nonatomic, strong) UIView *dataView;
@property (nonatomic, strong) UIImageView *remindImgView;
@property (nonatomic, strong) UILabel *remindLabel;

@end

@implementation ELKNoDataView


+ (instancetype)noDataWithImgName:(NSString *)imgName remind:(NSString *)remind
{
    UIImage *image = [UIImage elk_imageNamed:imgName];
    ELKNoDataView *noDataView = [self noDataWithImage:image remind:remind];
    return noDataView;
}


+ (instancetype)noDataWithImage:(UIImage *)image remind:(NSString *)remind
{
    ELKNoDataView *noDataView = [[[self class] alloc] init];
    noDataView.backgroundColor = [UIColor clearColor];
    [noDataView configNoDataView:image remind:remind];
    
    return noDataView;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.dataView.frame = CGRectMake((frame.size.width - 280.f) / 2.f, 0.f, 280.f, 240.f);
}

- (void)configNoDataView:(UIImage *)image remind:(NSString *)remind
{
    UIImage *noDataImage = image ?: [UIImage elk_imageNamed:@"ELKNoDataView/elk_no_data_icon"];
    if (!_dataView) {
        _dataView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 280.f, 240.f)];
        _dataView.backgroundColor = [UIColor clearColor];
        
        CGSize imgSize = noDataImage.size;
        CGFloat imgWidth = imgSize.width > 280.f ? 280.f : imgSize.width;
        CGFloat imgHeight = imgSize.height > 280.f ? 280.f : imgSize.height;
        
        _remindImgView = [[UIImageView alloc] initWithFrame:CGRectMake((280.f - imgWidth) / 2.f, 0.f, imgWidth, imgHeight)];
        [_remindImgView setImage:noDataImage];
        [_remindImgView setBackgroundColor:[UIColor clearColor]];
        [_dataView addSubview:_remindImgView];
        
        _remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, CGRectGetMaxY(_remindImgView.frame) + 24.f, CGRectGetWidth(_dataView.frame), 20.f)];
        _remindLabel.font = [UIFont systemFontOfSize:16.f];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.textColor = ELK_HexColor(0x333333, 1.f);
        _remindLabel.numberOfLines = 0;
        [_dataView addSubview:_remindLabel];
        [self addSubview:_dataView];
    }
    NSString *remindText = remind ?: @"暂无数据";
    CGSize imgSize = noDataImage.size;
    CGFloat imgWidth = imgSize.width > 280.f ? 280.f : imgSize.width;
    CGFloat imgHeight = imgSize.height > 280.f ? 280.f : imgSize.height;
    _remindImgView.frame = CGRectMake((280.f - imgWidth) / 2.f, 0.f, imgWidth, imgHeight);
    CGSize remindSize = [ELKUtilQuant sizeOfString:remindText limitSize:CGSizeMake(CGRectGetWidth(_dataView.frame), 150.f) fontSize:16.f];
    _remindLabel.frame = CGRectMake(0.f, CGRectGetMaxY(_remindImgView.frame) + 24.f, CGRectGetWidth(_dataView.frame), remindSize.height);
    
    [_remindImgView setImage:noDataImage];
    _remindLabel.text = remindText;
    
}



@end
