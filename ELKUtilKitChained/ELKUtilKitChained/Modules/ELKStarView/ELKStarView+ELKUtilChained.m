//
//  ELKStarView+ELKUtilChained.m
//  ELKUtilKit-Chained
//
//  Created by wing on 2019/7/6.
//  Copyright © 2019 wing. All rights reserved.
//

#import "ELKStarView+ELKUtilChained.h"

@implementation ELKStarView (ELKUtilChained)


- (ELKStarView * _Nonnull (^)(BOOL))elk_setTouchEnable
{
    return ^(BOOL enable) {
        [self setTouchEnable:enable];
        return self;
    };
}


- (ELKStarView * _Nonnull (^)(ELKStarAtomicity))elk_setStarAtomicity
{
    return ^(ELKStarAtomicity atomicity) {
        [self setStarAtomicity:atomicity];
        return self;
    };
}


- (ELKStarView * _Nonnull (^)(id<ELKStarRatingViewDelegate> _Nonnull))elk_setDelegate
{
    return ^(id<ELKStarRatingViewDelegate> delegate) {
        [self setDelegate:delegate];
        return self;
    };
}


- (ELKStarView * _Nonnull (^)(CGFloat, CGFloat, NSInteger, NSString * _Nonnull, NSString * _Nonnull))elk_setStarSpaceWidthNumAndImage
{
    return ^(CGFloat space, CGFloat starWidth, NSInteger starNum, NSString * _Nonnull backStar, NSString * _Nonnull foreStar) {
        [self setStarSpace:space starWidth:starWidth starNumber:starNum backStar:backStar foreStar:foreStar];
        return self;
    };
}


- (ELKStarView * _Nonnull (^)(CGFloat, BOOL))elk_setScoreWithAnimation
{
    return ^(CGFloat score, BOOL animated) {
        [self setScore:score withAnimation:animated];
        return self;
    };
}


- (ELKStarView * _Nonnull (^)(CGFloat, BOOL, ELKStarSetScoreCompletion _Nullable))elk_setScoreWithAnimationCompletion
{
    return ^(CGFloat score, BOOL animated, ELKStarSetScoreCompletion _Nullable completion) {
        [self setScore:score withAnimation:animated completion:completion];
        return self;
    };
}




@end
