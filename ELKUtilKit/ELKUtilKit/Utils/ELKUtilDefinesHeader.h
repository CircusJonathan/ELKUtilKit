//
//  ELKUtilDefinesHeader.h
//  ELKUtilKit
//
//  Created by wing on 2019/7/3.
//  Copyright © 2019 wing. All rights reserved.
//

#ifndef ELKUtilDefinesHeader_h
#define ELKUtilDefinesHeader_h


#import "NSBundle+ELKUtilResources.h"
#import "UIImage+ELKUtilResources.h"




// 颜色宏
#ifndef ELK_HexColor
#define ELK_HexColor(colorH,a) [UIColor colorWithRed:((float)((colorH & 0xff0000) >> 16)) / 255.0 green:((float)((colorH & 0x00ff00) >> 8)) / 255.0 blue:((float)(colorH & 0x0000ff)) / 255.0 alpha:a]
#endif


// 硬件屏幕尺寸
#ifndef ELKScreenWidth
#define ELKScreenWidth        ([[UIScreen mainScreen] bounds].size.width)
#define ELKScreenHeight       ([[UIScreen mainScreen] bounds].size.height)
#endif








#endif /* ELKUtilDefinesHeader_h */
