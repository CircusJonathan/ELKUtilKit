//
//  ELKUtilQuant.m
//  ELKUtilKit
//
//  Created by wing on 2019/7/4.
//  Copyright © 2019 wing. All rights reserved.
//

#import "ELKUtilQuant.h"
#import "ELKUtilDefinesHeader.h"

@implementation ELKUtilQuant





+ (CGSize)sizeOfString:(NSString *)string limitSize:(CGSize)limitSize fontSize:(CGFloat)font
{
    CGSize strSize = [string boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return strSize;
}






// Navigation status bar height
CGFloat ELK_navStatusHeight(void)
{
    CGFloat statusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
    return statusBar;
}

// The safe top height of Screen
CGFloat ELK_safeTop(BOOL navHidden)
{
    CGFloat safeTop = ELK_navStatusHeight();
    if (!navHidden) {
        safeTop += 44.f;
    }
    return safeTop;
}

// The safe bottom height of Screen
CGFloat ELK_safeBottom(void)
{
    CGFloat safeBottom = 0.f;
    if (ELK_navStatusHeight() >= 21.f) {
        safeBottom = 34.f;
    }
    return safeBottom;
}

// The safe width of screen
CGFloat ELK_safeWidth(void)
{
    return [UIScreen mainScreen].bounds.size.width;
}

// The safe height of screen
CGFloat ELK_safeHeight(BOOL navHidden)
{
    CGFloat safeHeight = [UIScreen mainScreen].bounds.size.height;
    if (navHidden) {
        if (ELK_navStatusHeight() >= 21.f) {
            safeHeight = [UIScreen mainScreen].bounds.size.height - 44.f - 34.f;
        }
    } else {
        if (ELK_navStatusHeight() >= 21.f) {
            safeHeight = [UIScreen mainScreen].bounds.size.height - 88.f - 34.f;
        } else {
            safeHeight = [UIScreen mainScreen].bounds.size.height - 64.f;
        }
    }
    return safeHeight;
}












@end
