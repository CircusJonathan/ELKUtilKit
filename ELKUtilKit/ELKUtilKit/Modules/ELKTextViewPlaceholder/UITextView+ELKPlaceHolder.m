//
//  UITextView+ELKPlaceHolder.m
//  ELKUtilKit
//
//  Created by wing on 2016/7/4.
//  Copyright © 2016 wing. All rights reserved.
//

#import "UITextView+ELKPlaceHolder.h"
#import "ELKUtilSwizzling.h"
#import "ELKUtilDefinesHeader.h"


static const char *elkPlaceHolderTextView = "elkPlaceHolderTextView";
static const char *elkPlaceHolderColor    = "elkPlaceHolderColor";
static const char *elkPlaceHolder         = "elkPlaceHolder";
static const char *elkMaximumTextLength   = "elkMaximumTextLength";


@interface UITextView ()

@property (nonatomic, strong) UITextView *placeHolderTextView;
@property (nonatomic, strong) NSNumber *maximumTextLength;

@end


@implementation UITextView (ELKPlaceHolder)


- (UITextView *)placeHolderTextView
{
    UITextView *textView = objc_getAssociatedObject(self, elkPlaceHolderTextView);
    if (!textView) {
        textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = ELK_HexColor(0x979797, 1.f);
        textView.userInteractionEnabled = NO;
        [textView setEditable:NO];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(elk_textViewDidBeginEditing) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(elk_textViewDidEndEditing) name:UITextViewTextDidEndEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(elk_textViewDidChange) name:UITextViewTextDidChangeNotification object:nil];
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
    }
    
    return textView;
}

- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView
{
    objc_setAssociatedObject(self, elkPlaceHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)elk_setFont:(UIFont *)font
{
    [self elk_setFont:font];
    [self.placeHolderTextView elk_setFont:font];
}

- (void)elk_setCText:(NSString *)text
{
    [self elk_setCText:text];
    self.placeHolderTextView.hidden = text.length;
}

- (NSString *)placeHolder
{
    NSString *pholderString = objc_getAssociatedObject(self, elkPlaceHolder);
    if (!pholderString) {
        pholderString = @"";
        [self setPlaceHolder:pholderString];
    }
    return pholderString;
}
- (void)setPlaceHolder:(NSString *)placeHolder
{
    objc_setAssociatedObject(self, elkPlaceHolder, placeHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.placeHolderTextView elk_setCText:placeHolder];
}

- (UIColor *)placeHolderColor
{
    UIColor *phColor = objc_getAssociatedObject(self, elkPlaceHolderColor);
    if (!phColor) {
        phColor = ELK_HexColor(0x979797, 1.f);
        [self setPlaceHolderColor:phColor];
    }
    return phColor;
}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    objc_setAssociatedObject(self, elkPlaceHolderColor, placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.placeHolderTextView.textColor = placeHolderColor;
}

- (void)setMaxTextLength:(NSInteger)maxTextLength
{
    if (maxTextLength <= 0) {
        maxTextLength = floorl(MAXFLOAT);
    }
    [self setMaximumTextLength:[NSNumber numberWithInteger:maxTextLength]];
}

- (NSNumber *)maximumTextLength
{
    NSNumber *maximum = objc_getAssociatedObject(self, elkMaximumTextLength);
    if (!maximum) {
        maximum = [NSNumber numberWithInteger:floorl(MAXFLOAT)];
        [self setMaximumTextLength:maximum];
    }
    return maximum;
}
- (void)setMaximumTextLength:(NSNumber *)maximumTextLength
{
    if ([maximumTextLength integerValue] <= 0) {
        maximumTextLength = [NSNumber numberWithInteger:floorl(MAXFLOAT)];
    }
    objc_setAssociatedObject(self, elkMaximumTextLength, maximumTextLength, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ELKTextViewDidChangeBlock)textViewDidChangeBlock
{
    return objc_getAssociatedObject(self, @selector(textViewDidChangeBlock));
}
- (void)setTextViewDidChangeBlock:(ELKTextViewDidChangeBlock)textViewDidChangeBlock
{
    objc_setAssociatedObject(self, @selector(textViewDidChangeBlock), textViewDidChangeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)elk_textViewDidBeginEditing
{
    self.placeHolderTextView.hidden = self.text.length;
}
- (void)elk_textViewDidEndEditing
{
    self.placeHolderTextView.hidden = self.text.length;
}
- (void)elk_textViewDidChange
{
    NSString *toBeString = self.text;
    
    NSArray *current = [UITextInputMode activeInputModes];
    UITextInputMode *currentInputMode = [current firstObject];
    NSString *lang = [currentInputMode primaryLanguage];
    NSInteger maxTextLength = [self.maximumTextLength integerValue];
    
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > maxTextLength) {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxTextLength];
                if (rangeIndex.length == 1) {
                    [self elk_setCText:[toBeString substringToIndex:maxTextLength]];
                } else {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxTextLength)];
                    [self elk_setCText:[toBeString substringWithRange:rangeRange]];
                }
            }
        }
    } else {
        if (toBeString.length > maxTextLength) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxTextLength];
            if (rangeIndex.length == 1) {
                [self elk_setCText:[toBeString substringToIndex:maxTextLength]];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxTextLength)];
                [self elk_setCText:[toBeString substringWithRange:rangeRange]];
            }
        }
    }
    if (self.textViewDidChangeBlock) {
        self.textViewDidChangeBlock(self.text);
    }
    self.placeHolderTextView.hidden = self.text.length;
    
}

+ (void)load
{
    [super load];
    
    [ELKUtilSwizzling exchangeMethodWithClass:self oriMethod:@selector(setFont:) newMethod:@selector(elk_setFont:)];
    
    [ELKUtilSwizzling exchangeMethodWithClass:self oriMethod:@selector(setText:) newMethod:@selector(elk_setCText:)];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}



@end
