//
//  UIImage+ELKUtilResources.m
//  ELKUtilKit
//
//  Created by wing on 2019/7/3.
//  Copyright © 2019 wing. All rights reserved.
//

#import "UIImage+ELKUtilResources.h"
#import "NSBundle+ELKUtilResources.h"


@implementation UIImage (ELKUtilResources)


+ (UIImage *)elk_imageNamed:(NSString *)imageName
{
    NSBundle *utilBundle = [NSBundle elk_utilBundle];
    UIImage *image = [UIImage imageNamed:imageName inBundle:utilBundle compatibleWithTraitCollection:nil];
    if (!image) {
        image = [UIImage imageNamed:imageName];
    }
    
    return image;
}



@end
