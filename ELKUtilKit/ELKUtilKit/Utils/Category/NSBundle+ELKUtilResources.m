//
//  NSBundle+ELKUtilResources.m
//  ELKUtilKit
//
//  Created by wing on 2019/7/3.
//  Copyright © 2019 wing. All rights reserved.
//

#import "NSBundle+ELKUtilResources.h"
#import "ELKUtilSwizzling.h"

@implementation NSBundle (ELKUtilResources)


+ (instancetype)elk_utilBundle
{
    static NSBundle *utilBundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *mainBundle = [NSBundle bundleForClass:[ELKUtilSwizzling class]];
        utilBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"ELKUtilResources" ofType:@"bundle"]];
        if (!utilBundle) {
            utilBundle = mainBundle;
        }
    });
    return utilBundle;
}






@end
