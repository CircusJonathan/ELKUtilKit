//
//  ELKUtilQuant.h
//  ELKUtilKit
//
//  Created by wing on 2019/7/4.
//  Copyright © 2019 wing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELKUtilQuant : NSObject





+ (CGSize)sizeOfString:(NSString *)string limitSize:(CGSize)limitSize fontSize:(CGFloat)font;












/**
 Navigation status bar height

 @return status bar height
 */
CGFloat ELK_navStatusHeight(void);

/**
 The safe top height of Screen

 @param navHidden If navigation Bar hidden
 @return          Safe top height
 */
CGFloat ELK_safeTop(BOOL navHidden);

/**
 The safe bottom height of Screen

 @return  Safe bottom height
 */
CGFloat ELK_safeBottom(void);

/**
 The safe width of screen

 @return  Safe width
 */
CGFloat ELK_safeWidth(void);

/**
 The safe height of screen

 @param navHidden If navigation Bar hidden
 @return  Safe height
 */
CGFloat ELK_safeHeight(BOOL navHidden);



@end

NS_ASSUME_NONNULL_END
