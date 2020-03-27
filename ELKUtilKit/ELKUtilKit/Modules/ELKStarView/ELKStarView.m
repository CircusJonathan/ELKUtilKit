//
//  ELKStarView.m
//  ELKUtilKit
//
//  Created by Jonathan on 16/1/13.
//  Copyright © 2016年 wing. All rights reserved.
//

#import "ELKStarView.h"
#import "ELKUtilDefinesHeader.h"


#define ELK_BACKGROUND_STAR @"ELKStarView/elk_star_big_off"
#define ELK_FOREGROUND_STAR @"ELKStarView/elk_star_big_on"
#define ELK_NUMBER_OF_STAR  5


@interface ELKStarView ()

@property (nonatomic, assign) CGFloat starSpace;
@property (nonatomic, assign) NSInteger numberOfStar;
@property (nonatomic, assign) CGFloat currentStarNum;
@property (nonatomic, copy) NSString *backImage;
@property (nonatomic, copy) NSString *foreImage;
@property (nonatomic, assign) CGFloat elkStarWidth;

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;
@property (nonatomic, assign) CGFloat minTouchLoc;
@property (nonatomic, assign) CGFloat maxTouchLoc;

@end

@implementation ELKStarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configBaseData];
    }
    [self setScore:self.currentStarNum withAnimation:NO];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStar:(NSInteger)number
{
    self = [self initWithFrame:frame];
    if (self) {
        self.numberOfStar = number;
        [self commonInit];
    }
    [self setScore:self.currentStarNum withAnimation:NO];
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame space:(CGFloat)space numberOfStar:(NSInteger)number
{
    self = [self initWithFrame:frame];
    if (self) {
        self.starSpace = space;
        self.numberOfStar = number;
        [self commonInit];
    }
    [self setScore:self.currentStarNum withAnimation:NO];
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame numberOfStar:(NSInteger)number backStar:(NSString *)backStar andForeStar:(NSString *)foreStar
{
    self = [self initWithFrame:frame];
    if (self) {
        self.numberOfStar = number;
        self.backImage = backStar;
        self.foreImage = foreStar;
        [self commonInit];
    }
    [self setScore:self.currentStarNum withAnimation:NO];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame space:(CGFloat)space numberOfStar:(NSInteger)number backStar:(NSString *)backStar andForeStar:(NSString *)foreStar
{
    self = [self initWithFrame:frame];
    if (self) {
        self.numberOfStar = number;
        self.starSpace = space;
        self.backImage = backStar;
        self.foreImage = foreStar;
        [self commonInit];
    }
    [self setScore:self.currentStarNum withAnimation:NO];
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configBaseData];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
    [self setScore:self.currentStarNum withAnimation:NO];
}
- (void)configBaseData
{
    self.numberOfStar = ELK_NUMBER_OF_STAR;
    self.starSpace = 0;
    self.currentStarNum = 0.f;
    self.foreImage = ELK_FOREGROUND_STAR;
    self.backImage = ELK_BACKGROUND_STAR;
    self.touchEnable = NO;
    self.starAtomicity = ELKAtomicityTiny;
    self.minTouchLoc = 0.f;
    self.maxTouchLoc = 0.f;
}

- (void)commonInit
{
    self.starBackgroundView = [self buildStarViewWithImageName:self.backImage];
    self.starForegroundView = [self buildStarViewWithImageName:self.foreImage];
    [self addSubview:self.starBackgroundView];
    [self addSubview:self.starForegroundView];
}
- (NSString *)backImage
{
    return _backImage ?: ({
        _backImage = ELK_BACKGROUND_STAR;
        _backImage;
    });
}
- (NSString *)foreImage
{
    return _foreImage ?: ({
        _foreImage = ELK_FOREGROUND_STAR;
        _foreImage;
    });
}
- (NSInteger)numberOfStar
{
    return _numberOfStar ?: ({
        _numberOfStar = ELK_NUMBER_OF_STAR;
        _numberOfStar;
    });
}

- (void)setStarSpace:(CGFloat)space starWidth:(CGFloat)starWidth starNumber:(NSInteger)starNum backStar:(NSString *)backStr foreStar:(NSString *)foreStar
{
    self.starSpace = space;
    self.elkStarWidth = starWidth;
    self.numberOfStar = starNum;
    self.backImage = backStr;
    self.foreImage = foreStar;
    self.currentStarNum = 0.f;
}

#pragma mark - Set Score
// 设置星星分数
- (void)setScore:(CGFloat)score withAnimation:(BOOL)animate
{
    [self setScore:score withAnimation:animate completion:nil];
}
- (void)setScore:(CGFloat)score withAnimation:(BOOL)animate completion:(ELKStarSetScoreCompletion)completion
{
//    NSAssert((score >= 0.0)&&(score <= self.numberOfStar), @"score must be between 0 and numberOfStar");
    CGFloat grade = score;
    if (grade < 0) {
        grade = 0;
    }
    if (grade > self.numberOfStar) {
        grade = self.numberOfStar;
    }
    self.currentStarNum = grade;
    
    [self changeStarShowNum:self.currentStarNum animate:animate completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

#pragma mark - Touche Event
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.touchEnable) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        if (CGRectContainsPoint(rect, point)) {
            [self earnStarGradeWithPoint:point];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.touchEnable) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        if (CGRectContainsPoint(rect, point)) {
            [self earnStarGradeWithPoint:point];
        }
    }
}

#pragma mark - Build Star View
// 通过图片构建星星视图
- (UIView *)buildStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    CGFloat starHeight = frame.size.height;
    if (self.elkStarWidth == 0) {
        self.elkStarWidth = (frame.size.width + self.starSpace) / self.numberOfStar;
    }
    CGFloat starW = self.elkStarWidth * self.numberOfStar + self.starSpace * (self.numberOfStar - 1);
    self.minTouchLoc = (frame.size.width - starW) / 2.f;
    self.maxTouchLoc = (frame.size.width - starW) / 2.f + starW;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.minTouchLoc, 0.f, starW, starHeight)];
    view.clipsToBounds = YES;
    
    for (int i = 0; i < self.numberOfStar; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage elk_imageNamed:imageName]];
        imageView.frame = CGRectMake(i * (self.elkStarWidth + self.starSpace), (starHeight - self.elkStarWidth) / 2.f, self.elkStarWidth, self.elkStarWidth);
        [view addSubview:imageView];
    }
    return view;
}
#pragma mark - Change Star Foreground With Point
// 通过坐标位置计算分数
- (void)earnStarGradeWithPoint:(CGPoint)point
{
    CGFloat grade = 0.f;
    if (point.x >= self.minTouchLoc) {
        grade = point.x - self.minTouchLoc;
    }
    if (point.x > self.maxTouchLoc) {
        grade = self.maxTouchLoc - self.minTouchLoc;
    }
    
    for (int i = 0; i < self.numberOfStar; i++) {
        if ((grade >= (self.elkStarWidth * (i + 1) + i * self.starSpace)) && (grade <= (self.elkStarWidth + self.starSpace) * (i + 1))) {
            grade = self.elkStarWidth * (i + 1);
            break;
        }
        if ((grade >= i * (self.elkStarWidth + self.starSpace)) && (grade <= i * (self.elkStarWidth + self.starSpace) + self.elkStarWidth)) {
            grade = grade - i * self.starSpace;
            break;
        }
    }
    
    NSString *str = [NSString stringWithFormat:@"%.2f", (1.f * grade / self.elkStarWidth)];
    self.currentStarNum = [str floatValue];
    NSLog(@"ELKStar Current Star Number %f", self.currentStarNum);
    [self changeStarShowNum:self.currentStarNum animate:YES completion:nil];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(starRatingView:score:)]) {
            [self.delegate starRatingView:self score:self.currentStarNum];
        }
    }
    
}

- (void)setCurrentStarNum:(CGFloat)currentStarNum
{
    CGFloat atomStar = currentStarNum;
    if (self.starAtomicity == ELKAtomicityHalf) {
        // 模糊半数计数
        atomStar = 0.5f * floor((currentStarNum + 0.25f) * 2);
    } else if (self.starAtomicity == ELKAtomicityRound) {
        // 模糊整数计数
        atomStar = 1.f * floor(currentStarNum + 0.5f);
    }
    
    _currentStarNum = atomStar;
}

- (void)changeStarShowNum:(CGFloat)grade animate:(BOOL)animate completion:(ELKStarSetScoreCompletion)completion
{
    NSInteger starNum = floor(grade);
    CGFloat separate = grade - floor(grade);
    CGFloat highLightWidth = starNum * (self.elkStarWidth + self.starSpace) + separate * self.elkStarWidth;
    
    if (animate) {
        [UIView animateWithDuration:0.2f animations:^{
            self.starForegroundView.frame = CGRectMake(CGRectGetMinX(self.starForegroundView.frame), 0, highLightWidth, self.frame.size.height);
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
    } else {
        self.starForegroundView.frame = CGRectMake(CGRectGetMinX(self.starForegroundView.frame), 0, highLightWidth, self.frame.size.height);
    }
    
}


@end
