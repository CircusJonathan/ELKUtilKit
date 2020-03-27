//
//  ViewController.m
//  ELKUtilKit
//
//  Created by wing on 2020/3/27.
//  Copyright © 2020 wing. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()<ELKStarRatingViewDelegate>

@property (nonatomic, strong) UIImage *picImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.elk_setBackgroundColor(UIColor.darkGrayColor);
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture1:)];
    UIImageView *imageV1 = [UIImageView elk_makeBlock:^(UIImageView * _Nonnull make) {
        make.elk_setFrame(CGRectMake(10.f, 60.f, 100.f, 130.f))
        .elk_setBackgroundColor(UIColor.orangeColor);
        make.elk_setUserInteractionEnable(YES)
        .elk_addGesture(tap1);
    }];
    NSString *imgString = @"https://www.52bnt.com/file/load?url=L2ZzL3dvcmsvdXBsb2FkLzIwMTktMDYtMTlfMDEvYWJjYjIxMWMtNWNlOC00MGU3LTgzZGYtZTU5ZDlmMjBhMmZhLnBuZw==";
    [imageV1 sd_setImageWithURL:[NSURL URLWithString:imgString]];
    [imageV1 sd_setImageWithURL:[NSURL URLWithString:imgString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.picImage = image;
    }];
        
    self.view.elk_addSubview(imageV1);
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture2:)];
    UIImageView *imgV2 = [UIImageView elk_makeBlock:^(UIImageView * _Nonnull make) {
        make.elk_setFrameMake(120.f, 80.f, 90, 130)
        .elk_setBackgroundColor(UIColor.redColor)
        .elk_addGesture(tap2)
        .elk_setUserInteractionEnable(YES);
        make.elk_setImage([UIImage imageNamed:@"elk_star_pic2"]);
    }];
    self.view.elk_addSubview(imgV2);
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture3:)];
    UIImageView *imgV3 = [UIImageView elk_makeBlock:^(UIImageView * _Nonnull make) {
        make.elk_setFrameMake(50.f, 280.f, 130, 60)
        .elk_setBackgroundColor(UIColor.redColor)
        .elk_setContentMode(UIViewContentModeScaleAspectFill)
        .elk_setClipToBounds(YES)
        .elk_addGesture(tap3)
        .elk_setUserInteractionEnable(YES);
        make.elk_setImage([UIImage imageNamed:@"elk_star_pic3"]);
    }];
    self.view.elk_addSubview(imgV3);
    
    ELKStarView *starView = [[ELKStarView alloc] initWithFrame:CGRectMake(5.f, 350.f, 310.f, 80.f) numberOfStar:5];
    starView.touchEnable = NO;
    starView.delegate = self;
    starView.starAtomicity = ELKAtomicityHalf;
    self.view.elk_addSubview(starView);
        
    UITextField *tField = [UITextField elk_makeBlock:^(UITextField * _Nonnull make) {
        make.elk_setFrameMake(20.f, 440.f, 120.f, 30.f);
        make.elk_setPlaceholder(@"请输入数字");
    }];
    self.view.elk_addSubview(tField);
    
    UIButton *btn = [UIButton elk_makeWithType:UIButtonTypeCustom block:^(UIButton * _Nonnull make) {
        make.elk_setFrameMake(160.f, 440.f, 60.f, 30)
        .elk_setBackgroundColor(UIColor.redColor);
    }];
    btn.elk_addTargetBlock(UIControlEventTouchUpInside, ^(UIButton * _Nonnull sender) {
        CGFloat score = [tField.text floatValue] ?: 0.f;
        [starView setScore:score withAnimation:YES];
    });
    self.view.elk_addSubview(btn);
        
        
    UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(100.f, 200.f, 200.f, 90.f)];
    textV.elk_setPlaceHolder(@"哈哈哈啊哈哈")
    .elk_setMaxTextLength(15)
    .elk_setText(@"hello world!")
    .elk_setFont([UIFont systemFontOfSize:20]);
    self.view.elk_addSubview(textV);
    
    
    [ELKPapawView refreshPapawViewWithNum:3 block:^{
        
    }];
    
    
    [self.view addSubview:[ELKNoDataView noDataWithImgName:nil remind:nil]];
        
        
        
    UIButton *bbb = [UIButton elk_makeWithType:UIButtonTypeCustom block:^(UIButton * _Nonnull make) {
       make.elk_setFrameMake(20.f, self.view.frame.size.height - 80.f, 100.f, 45.f)
        .elk_setBackgroundColor(UIColor.greenColor);
        make.elk_setTitleForNormal(@"下一页")
        .elk_setTitleForSelected(@"下一页");
    }];
    bbb.elk_addTargetBlock(UIControlEventTouchUpInside, ^(UIButton * _Nonnull sender) {
        SecondViewController *secondVC = [[SecondViewController alloc] init];
        [self presentViewController:secondVC animated:YES completion:nil];
    });
    self.view.elk_addSubview(bbb);
        
}
- (void)starRatingView:(ELKStarView *)starView score:(CGFloat)score
{
    NSLog(@"lllllllllll %.2f", score);
}

- (void)tapGesture1:(UIGestureRecognizer *)gesture
{
    [ELKGalleryShowView showGallery:@"https://www.52bnt.com/file/load?url=L2ZzL3dvcmsvdXBsb2FkLzIwMTktMDYtMTlfMDEvYWJjYjIxMWMtNWNlOC00MGU3LTgzZGYtZTU5ZDlmMjBhMmZhLnBuZw==" placeHolder:nil imgView:gesture.view];
    
}

- (void)tapGesture2:(UIGestureRecognizer *)gesture
{
    [ELKGalleryShowView showGallery:@"elk_star_pic2" imgView:gesture.view];
}

- (void)tapGesture3:(UIGestureRecognizer *)gesture
{
    [ELKGalleryShowView showGalleryImg:[UIImage imageNamed:@"elk_star_pic3"] imgView:gesture.view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.view.elk_endEditing(YES);
    
}

@end
