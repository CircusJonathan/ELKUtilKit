//
//  ELKSegmentControl.m
//  ELKUtilKit
//
//  Created by wing on 2017/11/30.
//  Copyright © 2017年 wing. All rights reserved.
//

#import "ELKSegmentControl.h"
#import "ELKUtilDefinesHeader.h"

@interface ELKSegmentItemView : UIControl

@property (nonatomic, assign) NSInteger itemIndex;

+ (instancetype)segmentItemView:(NSString *)title;

- (void)setItemLabelText:(NSString *)title;

@end

@interface ELKSegmentControl ()

@property (nonatomic, strong) NSMutableArray *itemsArray;

@property (nonatomic, strong) UIImageView *backImgView;

@property (nonatomic, strong) UIImageView *selImgView;

@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;

@property (nonatomic, assign, readwrite) NSInteger selectIndex;

@end

@implementation ELKSegmentControl

- (instancetype)initWithItemsArray:(nonnull NSArray *)items
{
    self = [super init];
    self.segmentAnimate = YES;
    if (self) {
        _itemsArray = [[NSMutableArray alloc] initWithArray:items];
        _itemWidth = 0.f;
        _itemHeight = 0.f;
        _selectIndex = 0;
        _backImgView = [[UIImageView alloc] init];
        [_backImgView setImage:[UIImage elk_imageNamed:@"ELKSegmentControl/elk_segment_back"]];
        [self addSubview:_backImgView];
        
        _selImgView = [UIImageView new];
        [_selImgView setImage:[UIImage imageNamed:@"ELKSegmentControl/elk_segment_sel"]];
        [self addSubview:_selImgView];
        
        for (int i = 0; i < _itemsArray.count; i++) {
            NSString *title = _itemsArray[i];
            ELKSegmentItemView *segItemView = [ELKSegmentItemView segmentItemView:title];
            segItemView.itemIndex = i;
            [segItemView addTarget:self action:@selector(segItemAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:segItemView];
        }
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    NSInteger itemNum = 1;
    if (self.itemsArray.count > 0) {
        itemNum = self.itemsArray.count;
    }
    _itemWidth = CGRectGetWidth(frame) / itemNum;
    _itemHeight = CGRectGetHeight(frame);
    
    _backImgView.frame = CGRectMake(0.f, 0.f, CGRectGetWidth(frame), CGRectGetHeight(frame));
    _selImgView.frame = CGRectMake(0.f, 0.f, _itemWidth, _itemHeight);
    
    NSArray *subArray = [self subviews];
    for (UIView *subView in subArray) {
        if ([subView isKindOfClass:[ELKSegmentItemView class]]) {
            ELKSegmentItemView *segItem = (ELKSegmentItemView *)subView;
            segItem.frame = CGRectMake(segItem.itemIndex * _itemWidth, 0.f, _itemWidth, _itemHeight);
        }
    }
    
}

- (void)setTitle:(NSString *_Nonnull)title forSegmentAtIndex:(NSUInteger)index
{
    NSArray *subArray = [self subviews];
    
    for (UIView *subView in subArray) {
        if ([subView isKindOfClass:[ELKSegmentItemView class]]) {
            ELKSegmentItemView *segItem = (ELKSegmentItemView *)subView;
            if (segItem.itemIndex == index) {
                [segItem setItemLabelText:title];
            }
        }
    }
}

- (void)selectSegmentAtIndex:(NSInteger)index
{
    if (index < self.itemsArray.count) {
        self.selectIndex = index;
        [self setSegmentItemHighlight:index];
    }
}

- (void)setSegmentItemHighlight:(NSInteger)index
{
    if (self.segmentAnimate) {
        [UIView animateWithDuration:0.3f animations:^{
            self.selImgView.frame = CGRectMake(index * self.itemWidth, 0.f, self.itemWidth, self.itemHeight);
        }];
    } else {
        self.selImgView.frame = CGRectMake(index * self.itemWidth, 0.f, self.itemWidth, self.itemHeight);
    }
}

- (void)segItemAction:(ELKSegmentItemView *)segment
{
    NSLog(@"ELKSegmentItemView select index %ld", (long)segment.itemIndex);
    [self setSegmentItemHighlight:segment.itemIndex];
    self.selectIndex = segment.itemIndex;
    if (self.segmentControlBlock) {
        self.segmentControlBlock(segment.itemIndex);
    }
}


@end

@interface ELKSegmentItemView ()

@property (nonatomic, strong) UILabel *itemLabel;

@end

@implementation ELKSegmentItemView

+ (instancetype)segmentItemView:(NSString *)title
{
    ELKSegmentItemView *segmentItem = [[[self class] alloc] init];
    [segmentItem setBackgroundColor:[UIColor clearColor]];
    
    segmentItem.itemLabel = [UILabel new];
    [segmentItem addSubview:segmentItem.itemLabel];
    [segmentItem.itemLabel setTextColor:[UIColor blackColor]];
    [segmentItem.itemLabel setFont:[UIFont systemFontOfSize:14.f]];
    [segmentItem.itemLabel setAdjustsFontSizeToFitWidth:YES];
    [segmentItem.itemLabel setMinimumScaleFactor:0.6];
    [segmentItem.itemLabel setTextAlignment:NSTextAlignmentCenter];
    [segmentItem setItemLabelText:title];
    
    return segmentItem;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _itemLabel.frame = CGRectMake(0.f, 0.f, CGRectGetWidth(frame), CGRectGetHeight(frame));
}

- (void)setItemLabelText:(NSString *)title
{
    _itemLabel.text = title;
}

@end
