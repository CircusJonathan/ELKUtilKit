//
//  SecondViewController.m
//  ELKUtilDemo
//
//  Created by wing on 2019/7/5.
//  Copyright © 2019 wing. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.elk_setBackgroundColor(UIColor.whiteColor);
    
    UITextView *textView = [UITextView elk_makeBlock:^(UITextView * _Nonnull make) {
        make.elk_setFrameMake(40.f, 64.f, 200.f, 100.f)
        .elk_setBackgroundColor(UIColor.greenColor);
        make.placeHolder = @"输入一段文字吧";
        [make setMaxTextLength:20];
    }];
    textView.textViewDidChangeBlock = ^(NSString * _Nullable text) {
        NSLog(@"%ld/20", (long)text.length);
    };
    
    textView.font = [UIFont systemFontOfSize:20];
    self.view.elk_addSubview(textView);
    
    UIButton *aaa = [UIButton elk_makeWithType:UIButtonTypeCustom block:^(UIButton * _Nonnull make) {
        make.elk_setFrameMake(20.f, textView.elk_maxY() + 20.f, 100.f, 45.f)
        .elk_setBackgroundColor(UIColor.greenColor);
        make.elk_setTitleForNormal(@"哈哈哈")
        .elk_setTitleForSelected(@"哈哈哈");
    }];
    aaa.elk_addTargetBlock(UIControlEventTouchUpInside, ^(UIButton * _Nonnull sender) {
        
    });
    self.view.elk_addSubview(aaa);
    
    UIButton *bbb = [UIButton elk_makeWithType:UIButtonTypeCustom block:^(UIButton * _Nonnull make) {
        make.elk_setFrameMake(20.f, self.view.frame.size.height - 80.f, 100.f, 45.f)
        .elk_setBackgroundColor(UIColor.greenColor);
        make.elk_setTitleForNormal(@"上一页")
        .elk_setTitleForSelected(@"上一页");
    }];
    bbb.elk_addTargetBlock(UIControlEventTouchUpInside, ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    self.view.elk_addSubview(bbb);
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.view.elk_endEditing(YES);
    
}

@end
