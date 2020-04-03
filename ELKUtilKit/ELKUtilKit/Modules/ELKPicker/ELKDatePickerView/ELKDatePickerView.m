//
//  ELKDatePickerView.m
//  ELKUtilKit
//
//  Created by wing on 2018/5/24.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "ELKDatePickerView.h"
#import "ELKUtilDefinesHeader.h"


@interface ELKDatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *pickView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *submitButton;

// 选择年月 展示时间
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *ymView;
@property (nonatomic, strong) UIPickerView *ymPickerView;
@property (nonatomic, strong) NSArray *yearArray;
@property (nonatomic, strong) NSArray *monthArray;
@property (nonatomic, copy) NSString *ymYear;
@property (nonatomic, copy) NSString *ymMonth;

@property (nonatomic, strong) UIDatePicker *datePickerView;

@property (nonatomic, strong) UIView *timeSelView;
@property (nonatomic, strong) UIPickerView *timePickerView;

// 选择钱包类型
@property (nonatomic, strong) NSString *walletType;
@property (nonatomic, strong) NSArray *walletArray;

@property (nonatomic, assign) ELKDatePickType dateType;

@property (nonatomic, copy) NSString *nowYear;
@property (nonatomic, copy) NSString *nowMonth;

@end

@implementation ELKDatePickerView

- (void)showDatePickerView:(ELKDatePickType)type
{
    _dateType = type;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if (type == ELKDatePickTypeDate) {
        self.datePickerView.hidden = NO;
        
    } else if (type == ELKDatePickTypeTime) {
        self.timeSelView.hidden = NO;
//        self.selATimeModel = nil;
//        [self.timePickerView reloadAllComponents];
//        [self.timePickerView selectRow:0 inComponent:0 animated:NO];
//        self.selATimeModel = [self.timeArray firstObject];
        
    } else if (type == ELKDatePickTypeWallet) {
        self.timeSelView.hidden = NO;
        self.walletType = @"";
        [self.timePickerView reloadAllComponents];
        [self.timePickerView selectRow:0 inComponent:0 animated:NO];
        self.walletType = [self.walletArray firstObject];
        
    } else {
        self.ymView.hidden = NO;
        self.timeLabel.hidden = NO;
        [self.ymPickerView selectRow:0 inComponent:0 animated:NO];
        [self.ymPickerView selectRow:0 inComponent:1 animated:NO];
        self.ymYear = [self.yearArray firstObject];
        self.ymMonth = [self.monthArray firstObject];
        self.timeLabel.text = [NSString stringWithFormat:@"%@-%@", self.ymYear, self.ymMonth];
        
    }
//    [UIView animateWithDuration:0.4f animations:^{
//        self.backView.backgroundColor = ELK_HexColor(0x000000, 0.4f);
//        self.pickView.frame = CGRectMake(0.f, ELKScreenHeight - 220.f - BtSafeBottom(), ELKScreenWidth, 220.f + BtSafeBottom());
//    }];
    
}
- (void)hiddenDatePickerView
{
//    [UIView animateWithDuration:0.3f animations:^{
//        self.backView.backgroundColor = ELK_HexColor(0x000000, 0.02f);
//        self.pickView.frame = CGRectMake(0.f, ELKScreenHeight, ELKScreenWidth, 220.f + BtSafeBottom());
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        self.datePickerView.hidden = YES;
//        self.timeSelView.hidden = YES;
//        self.ymView.hidden = YES;
//        self.timeLabel.hidden = YES;
//    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configPickView];
    }
    return self;
}

- (void)configPickView
{
    if (!_backView) {
        self.frame = [UIScreen mainScreen].bounds;
        _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = ELK_HexColor(0x000000, 0.4f);
        [self addSubview:_backView];
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_backView addGestureRecognizer:tapGest];
        
//        _pickView = [[UIView alloc] initWithFrame:CGRectMake(0.f, ELKScreenHeight, ELKScreenWidth, 220.f + BtSafeBottom())];
//        _pickView.backgroundColor = [UIColor whiteColor];
//        [_backView addSubview:_pickView];
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, ELKScreenWidth, 44.f)];
        _topView.backgroundColor = [UIColor clearColor];
        [_pickView addSubview:_topView];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0.f, 0.f, 60.f, 44.f);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_cancelButton setTitleColor:ELK_HexColor(0x333333, 1.f) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:_cancelButton];
        
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.frame = CGRectMake(ELKScreenWidth - 60.f, 0.f, 60.f, 44.f);
        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_submitButton setTitleColor:ELK_HexColor(0x333333, 1.f) forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:_submitButton];
        
        [_topView addSubview:self.timeLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 43.5f, ELKScreenWidth, 0.5f)];
        lineView.backgroundColor = ELK_HexColor(0x666666, 1.f);
        [_topView addSubview:lineView];
        
        // 配置日期选择器
        [self configDatePickerView];
        // 配置时间选择器
        [self configTimePickerView];
        // 配置年月选择器
        [self configYMPickerView];
        
    }
    [self.timePickerView reloadAllComponents];
    
    
}
// 配置日期选择器
- (void)configDatePickerView
{
    _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.f, 50.f, ELKScreenWidth, 160.f)];
    _datePickerView.backgroundColor = [UIColor clearColor];
    [_datePickerView setDatePickerMode:UIDatePickerModeDate];
    [_datePickerView setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [_datePickerView setTimeZone:[NSTimeZone defaultTimeZone]];
    // todo 日期限制
    _datePickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:24 * 60 * 60];//24 * 60 * 60];
    _datePickerView.minimumDate = [NSDate date];
    _datePickerView.maximumDate = [NSDate dateWithTimeIntervalSinceNow:365 * 24 * 60 * 60];
    [_datePickerView setValue:ELK_HexColor(0x333333, 1.f) forKeyPath:@"textColor"];
    [_datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [_pickView addSubview:_datePickerView];
    _datePickerView.hidden = YES;
}
// 配置时间选择器
- (void)configTimePickerView
{
    _timeSelView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 50.f, ELKScreenWidth, 160)];
    _timeSelView.backgroundColor = [UIColor whiteColor];
    
    _timePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.f, 50.f, ELKScreenWidth, 110.f)];
    _timePickerView.delegate = self;
    _timePickerView.dataSource = self;
    [_timeSelView addSubview:_timePickerView];
    
    [_pickView addSubview:_timeSelView];
    _timeSelView.hidden = YES;
    
}
// 配置时间选择器
- (void)configYMPickerView
{
    _ymView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 50.f, ELKScreenWidth, 160.f)];
    _ymView.backgroundColor = [UIColor whiteColor];
    
    _ymPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.f, 50.f, ELKScreenWidth, 110.f)];
    _ymPickerView.delegate = self;
    _ymPickerView.dataSource = self;
    [_ymView addSubview:_ymPickerView];
    
    [_pickView addSubview:_ymView];
    _ymView.hidden = YES;
    
}

- (void)dateChanged:(UIDatePicker *)dPicker
{
    NSLog(@"aaaaaaaa %@", dPicker.date);
}

- (void)cancelButtonAcion:(UIButton *)sender
{
    [self hiddenDatePickerView];
}

- (void)submitButtonAction:(UIButton *)sender
{
    if (self.dateType == ELKDatePickTypeDate) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormat stringFromDate:self.datePickerView.date];
        if (self.datePickerBlock) {
            self.datePickerBlock(ELKDatePickTypeDate, dateStr);
        }
    } else if (self.dateType == ELKDatePickTypeTime) {
        if (self.datePickerBlock) {
            self.datePickerBlock(ELKDatePickTypeTime, @"");
        }
        
    } else if (self.dateType == ELKDatePickTypeWallet) {
        if (self.datePickerBlock) {
            self.datePickerBlock(ELKDatePickTypeWallet, self.walletType);
        }
        
    } else {
        if (self.datePickerBlock) {
            self.datePickerBlock(ELKDatePickTypeYM, self.timeLabel.text);
        }
        
    }
    [self hiddenDatePickerView];
}

- (void)tapGesture:(UIGestureRecognizer *)gesture
{
    [self hiddenDatePickerView];
}

// pickerView delegate
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView
{
    if (pickerView == self.timePickerView) {
        return 1;
    }
    return 2;
}
- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rowNums = 0;
    if (pickerView == self.timePickerView) {
        if (self.dateType == ELKDatePickTypeWallet) {
            // wallet
            rowNums = self.walletArray.count;
        } else {
            // time
            rowNums = self.timeArray.count;
        }
        
    } else {
        if (component == 0) {
            rowNums = self.yearArray.count;
        } else {
            rowNums = self.monthArray.count;
        }
    }
    return rowNums;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 20.f;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (pickerView == self.timePickerView) {
        return ELKScreenWidth;
    }
    return ELKScreenWidth / 2.f;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.timePickerView) {
        if (self.dateType == ELKDatePickTypeWallet) {
            // wallet
            NSString *titleString = self.walletArray[row];
            return titleString;
        } else {
            // time
//            BtAppointTimeModel *aTimeModel = self.timeArray[row];
//            NSMutableString *titleString = [[NSMutableString alloc] initWithString:stdString(aTimeModel.time_template_name)];
//            if ([stdNumber(aTimeModel.status) isEqualToNumber:@1]) {
//                [titleString appendFormat:@"(%@)", stdString(aTimeModel.statusDesc)];
//            }
//            return titleString;
            return @"";
        }
    } else {
        if (component == 0) {
            NSString *year = self.yearArray[row];
            return year;
        } else {
            NSString *month = self.monthArray[row];
            return month;
        }
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger selRow = row;
    if (pickerView == self.timePickerView) {
        if (self.dateType == ELKDatePickTypeWallet) {
            if (row >= self.walletArray.count) {
                selRow = self.walletArray.count - 1;
            }
            self.walletType = self.walletArray[selRow];
            
        } else {
            if (row >= self.timeArray.count) {
                selRow = self.timeArray.count - 1;
            }
//            self.selATimeModel = self.timeArray[selRow];
        }

    } else if (pickerView == self.ymPickerView) {
        if (component == 0) {
            if (row >= self.yearArray.count) {
                selRow = self.yearArray.count - 1;
            }
            self.ymYear = self.yearArray[selRow];
        } else if (component == 1) {
            if (row >= self.monthArray.count) {
                selRow = self.monthArray.count - 1;
            }
            self.ymMonth = self.monthArray[selRow];
        }
        [self checkYMDateInfo];
        
    }
    
}
- (void)checkYMDateInfo
{
    if ([self.ymYear isEqualToString:self.nowYear]) {
        if ([self.ymMonth integerValue] > [self.nowMonth integerValue]) {
            self.ymMonth = [self.nowMonth copy];
        }
        [self.ymPickerView selectRow:([self.ymMonth integerValue] - 1) inComponent:1 animated:YES];
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@", self.ymYear, self.ymMonth];
}
//- (NSString *)nowYear
//{
//    return _nowYear ?: ({
//        _nowYear = [BtTool nowYear];
//        _nowYear;
//    });
//}
//- (NSString *)nowMonth
//{
//    return _nowMonth ?: ({
//        _nowMonth = [BtTool nowMonth];
//        _nowMonth;
//    });
//}

- (UILabel *)timeLabel
{
    return _timeLabel ?: ({
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.f, 10.f, ELKScreenWidth - 180.f, 20.f)];
        _timeLabel.font = [UIFont systemFontOfSize:14.f];
        _timeLabel.textColor = ELK_HexColor(0x333333, 1.f);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.hidden = YES;
        _timeLabel;
    });
}

- (NSArray *)yearArray
{
    return _yearArray ?: ({
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"YYYY"];
        NSString *yTime = [format stringFromDate:[NSDate date]];
        NSInteger year = [yTime integerValue];
        NSMutableArray *mutArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            [mutArray addObject:[NSString stringWithFormat:@"%ld", (long)year]];
            year--;
        }
        _yearArray = mutArray;
        _yearArray;
    });
}

- (NSArray *)monthArray
{
    return _monthArray ?: ({
        _monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",];
        _monthArray;
    });
}

- (NSArray *)walletArray
{
    return _walletArray ?: ({
        _walletArray = @[@"全部",@"支付",@"收入",@"充值",@"提现"];
        _walletArray;
    });
}

@end
