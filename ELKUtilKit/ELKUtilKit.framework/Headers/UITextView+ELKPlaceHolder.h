//
//  UITextView+ELKPlaceHolder.h
//  ELKUtilKit
//
//  Created by wing on 2016/7/4.
//  Copyright © 2016 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

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
 Set the font of the text, the placeholder's font size is same to text.

 @param font UIFont object
 */
- (void)elk_setFont:(UIFont *)font;


@end

NS_ASSUME_NONNULL_END
