//
//  ELKStarView+ELKUtilChained.h
//  ELKUtilKit-Chained
//
//  Created by wing on 2019/7/6.
//  Copyright © 2019 wing. All rights reserved.
//

#import <ELKUtilKit/ELKUtilKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELKStarView (ELKUtilChained)


@property (nonatomic, copy, readonly) ELKStarView * _Nonnull (^elk_setTouchEnable)(BOOL enable);

@property (nonatomic, copy, readonly) ELKStarView * _Nonnull (^elk_setStarAtomicity)(ELKStarAtomicity atomicity);

@property (nonatomic, copy, readonly) ELKStarView * _Nonnull (^elk_setDelegate)(id<ELKStarRatingViewDelegate> delegate);



/**
 Set the space between two neighboring stars, star width, total number of stars, background image name of star, and foreground image name of star
 */
@property (nonatomic, copy, readonly) ELKStarView * _Nonnull (^elk_setStarSpaceWidthNumAndImage)(CGFloat space, CGFloat starWidth, NSInteger starNum, NSString * _Nonnull backStar, NSString * _Nonnull foreStar);


/**
 Set star score (between maximum and minimum of stars)
 */
@property (nonatomic, copy, readonly) ELKStarView * _Nonnull (^elk_setScoreWithAnimation)(CGFloat score, BOOL animated);

@property (nonatomic, copy, readonly) ELKStarView * _Nonnull (^elk_setScoreWithAnimationCompletion)(CGFloat score, BOOL animated, ELKStarSetScoreCompletion _Nullable completion);



@end

NS_ASSUME_NONNULL_END
