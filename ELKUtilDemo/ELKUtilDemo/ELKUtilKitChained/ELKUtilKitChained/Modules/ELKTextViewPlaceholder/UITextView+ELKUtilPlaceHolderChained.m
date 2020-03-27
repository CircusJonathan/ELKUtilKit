//
//  UITextView+ELKUtilPlaceHolderChained.m
//  ELKUtilKit-Chained
//
//  Created by wing on 2019/7/6.
//  Copyright © 2019 wing. All rights reserved.
//

#import "UITextView+ELKUtilPlaceHolderChained.h"

@implementation UITextView (ELKUtilPlaceHolderChained)


/**
 Set placeholder
 */
- (UITextView * _Nonnull (^)(NSString * _Nullable))elk_setPlaceHolder
{
    return ^(NSString * _Nullable placeHolder) {
        [self setPlaceHolder:placeHolder];
        return self;
    };
}


/**
 Set placeholder color
 */
- (UITextView * _Nonnull (^)(UIColor * _Nullable))elk_setPlaceHolderColor
{
    return ^(UIColor * _Nullable placeHolderColor) {
        [self setPlaceHolderColor:placeHolderColor];
        return self;
    };
}


/**
 Set maximum length of input
 */
- (UITextView * _Nonnull (^)(NSInteger))elk_setMaxTextLength
{
    return ^(NSInteger maxLength) {
        [self setMaxTextLength:maxLength];
        return self;
    };
}






@end
