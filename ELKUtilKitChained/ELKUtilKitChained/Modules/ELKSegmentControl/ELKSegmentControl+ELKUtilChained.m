//
//  ELKSegmentControl+ELKUtilChained.m
//  ELKUtilKitChained
//
//  Created by wing on 2019/7/13.
//  Copyright © 2019 wing. All rights reserved.
//

#import "ELKSegmentControl+ELKUtilChained.h"

@implementation ELKSegmentControl (ELKUtilChained)


- (ELKSegmentControl * _Nonnull (^)(BOOL))elk_setSegmentAnimate
{
    return ^(BOOL animate) {
        self.segmentAnimate = animate;
        return self;
    };
}

- (ELKSegmentControl * _Nonnull (^)(NSString * _Nullable, NSUInteger))elk_setTitleAtIndex
{
    return ^(NSString * _Nullable title, NSUInteger index) {
        NSString *titleStr = title ?: @"";
        [self setTitle:titleStr forSegmentAtIndex:index];
        return self;
    };
}

- (ELKSegmentControl * _Nonnull (^)(NSUInteger))elk_selectSegmentAtIndex
{
    return ^(NSUInteger index) {
        [self selectSegmentAtIndex:index];
        return self;
    };
}



@end
