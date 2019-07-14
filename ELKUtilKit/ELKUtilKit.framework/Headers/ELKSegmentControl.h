//
//  ELKSegmentControl.h
//  ELKUtilKit
//
//  Created by wing on 2017/11/30.
//  Copyright © 2017年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ELKSegmentControlBlock)(NSInteger index);

@interface ELKSegmentControl : UIControl

@property (nonatomic, copy) ELKSegmentControlBlock segmentControlBlock;
@property (nonatomic, assign, readonly) NSInteger selectIndex;
@property (nonatomic, assign) BOOL segmentAnimate;


/**
 Initializes and returns a newly allocated view object with the specified items.

 @param items items array
 @return      ELKSegmentControl object
 */
- (instancetype)initWithItemsArray:(NSArray *)items;


/**
 Set item's title for segment at index

 @param title Title string
 @param index Index of segment
 */
- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index;


/**
 Select the item with the specified index

 @param index Index of segment
 */
- (void)selectSegmentAtIndex:(NSInteger)index;


@end
