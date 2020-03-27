//
//  ELKDatePickerView.h
//  ELKUtilKit
//
//  Created by wing on 2018/5/24.
//  Copyright © 2018年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ELKDatePickType) {
    ELKDatePickTypeDate     = 1 << 0,
    ELKDatePickTypeYM       = 1 << 1,
    ELKDatePickTypeTime     = 1 << 2,
    ELKDatePickTypeWallet   = 1 << 3,
    
};

typedef void(^ELKDatePickerBlock)(ELKDatePickType type, NSString *dateStr);

@interface ELKDatePickerView : UIView

@property (nonatomic, copy) ELKDatePickerBlock datePickerBlock;
@property (nonatomic, strong) NSArray *timeArray;


- (void)showDatePickerView:(ELKDatePickType)type;

- (void)hiddenDatePickerView;

@end
