//
//  ELKSegmentControl+ELKUtilChained.h
//  ELKUtilKitChained
//
//  Created by wing on 2017/11/30.
//  Copyright © 2017年 wing. All rights reserved.
//

#import <ELKUtilKit/ELKUtilKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELKSegmentControl (ELKUtilChained)


/**
 Set segment Animate
 */
@property (nonatomic, copy, readonly) ELKSegmentControl * _Nonnull (^elk_setSegmentAnimate)(BOOL animate);

/**
 Set item's title for segment at index
 */
@property (nonatomic, copy, readonly) ELKSegmentControl * _Nonnull (^elk_setTitleAtIndex)(NSString * _Nullable title, NSUInteger index);

/**
 Select the item with the specified index
 */
@property (nonatomic, copy, readonly) ELKSegmentControl * _Nonnull (^elk_selectSegmentAtIndex)(NSUInteger index);


@end

NS_ASSUME_NONNULL_END
