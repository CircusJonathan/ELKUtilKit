//
//  ELKPapawView.h
//  ELKUtilKit
//
//  Created by wing on 2018/4/26.
//  Copyright © 2018年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ELKPapawTapBlock)(void);

@interface ELKPapawView : UIView


+ (void)showPapawView;

+ (void)refreshPapawViewWithNum:(NSInteger)number block:(ELKPapawTapBlock)block;

+ (void)dismissPapawView;


@end

