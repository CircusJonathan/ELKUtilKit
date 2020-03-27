//
//  UITextView+ELKPlaceHolder.h
//  ELKUtilKit
//
//  Created by wing on 2016/7/4.
//  Copyright © 2016 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ELKTextViewDidChangeBlock)(NSString * _Nullable text);

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (ELKPlaceHolder)


/**
 The string that is displayed when there is no other text in the text view.
 */
@property (nonatomic, copy) NSString *placeHolder;
/**
 The placeholder's Color
 */
@property (nonatomic, strong) UIColor *placeHolderColor;
/**
 Notify when textview did changed
 */
@property (nonatomic, copy) ELKTextViewDidChangeBlock textViewDidChangeBlock;

/**
 Set maximum length of input
 */
- (void)setMaxTextLength:(NSInteger)maxLength;



@end

NS_ASSUME_NONNULL_END
