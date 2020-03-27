//
//  UITextView+ELKUtilPlaceHolderChained.h
//  ELKUtilKit-Chained
//
//  Created by wing on 2019/7/6.
//  Copyright © 2019 wing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELKUtilKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (ELKUtilPlaceHolderChained)


/**
 Set placeholder
 */
@property (nonatomic, copy, readonly) UITextView * _Nonnull (^elk_setPlaceHolder)(NSString * _Nullable placeHolder);

/**
 Set placeholder color
 */
@property (nonatomic, copy, readonly) UITextView * _Nonnull (^elk_setPlaceHolderColor)(UIColor * _Nullable placeHolderColor);


/**
 Set maximum length of input
 */
@property (nonatomic, copy, readonly) UITextView * _Nonnull (^elk_setMaxTextLength)(NSInteger maxLength);




@end

NS_ASSUME_NONNULL_END
