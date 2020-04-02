//
//  ELKGalleryShowView.h
//  ELKUtilKit
//
//  Created by wing on 2018/12/21.
//  Copyright © 2018 wing. All rights reserved.
//

#import "ELKGalleryShowView.h"
#import "ELKUtilDefinesHeader.h"
#import <SDWebImage/SDWebImage.h>


#define ELK_GalleryPlaceImage @"ELKGalleryView/elk_gallery_place_image"

@interface ELKGalleryShowView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGRect imgOriRect;

@end

@implementation ELKGalleryShowView


/**
 Full screen preview picture
 
 @param imageUrl Picture URL
 @param imgName  Placeholder Image's name
 @param imgView  The view that currently displays the image
 */
+ (void)showGallery:(nullable NSString *)imageUrl placeHolderName:(nullable NSString *)imgName imgView:(nonnull UIView *)imgView
{
    UIImage *placeImage = [UIImage elk_imageNamed:imgName];
    [self showGallery:imageUrl placeHolder:placeImage imgView:imgView];
}


/**
 Full screen preview picture
 
 @param imageUrl   Picture URL
 @param placeImage Placeholder Image
 @param imgView    The view that currently displays the image
 */
+ (void)showGallery:(NSString *)imageUrl placeHolder:(UIImage *)placeImage imgView:(UIView *)imgView
{
    ELKGalleryShowView *galleryView = [self sharedGalleryShowView];
    if (!placeImage) {
        placeImage = [UIImage elk_imageNamed:ELK_GalleryPlaceImage];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect oriRect = [imgView convertRect:imgView.bounds toView:window];
    
    [galleryView.scrollView setZoomScale:1.f animated:NO];
    galleryView.imgOriRect = oriRect;
    galleryView.imageView.contentMode = imgView.contentMode;
    galleryView.imageView.frame = CGRectMake(oriRect.origin.x, oriRect.origin.y, oriRect.size.width, oriRect.size.height);
    [galleryView setBackgroundColor:ELK_HexColor(0x000000, 0.02f)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGSize imgSize = placeImage.size;
        [self adjustGalleryImgView:imgSize duration:0.25f];
    });
    
    [galleryView.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CGSize imgSize = image.size;
                [self adjustGalleryImgView:imgSize duration:0.1f];
            });
        }
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:galleryView];
    
}


/**
 Full screen preview picture, use default placeholder image
 
 @param imgName Local Image's name
 @param imgView The view that currently displays the image
 */
+ (void)showGallery:(NSString *)imgName imgView:(UIView *)imgView
{
    UIImage *image = [UIImage elk_imageNamed:imgName];
    [self showGalleryImg:image imgView:imgView];
}

/**
 Full screen preview picture, use default placeholder image
 
 @param image   UIImage object
 @param imgView The view that currently displays the image
 */
+ (void)showGalleryImg:(UIImage *)image imgView:(UIView *)imgView
{
    ELKGalleryShowView *galleryView = [self sharedGalleryShowView];
    
    UIImage *placeImage = [UIImage elk_imageNamed:ELK_GalleryPlaceImage];
    placeImage = image ?: placeImage;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect oriRect = [imgView convertRect:imgView.bounds toView:window];
    
    [galleryView.scrollView setZoomScale:1.f animated:NO];
    galleryView.imgOriRect = oriRect;
    galleryView.imageView.contentMode = imgView.contentMode;
    galleryView.imageView.frame = CGRectMake(oriRect.origin.x, oriRect.origin.y, oriRect.size.width, oriRect.size.height);
    [galleryView setBackgroundColor:ELK_HexColor(0x000000, 0.02f)];
    [galleryView.imageView setImage:placeImage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGSize imgSize = placeImage.size;
        [self adjustGalleryImgView:imgSize duration:0.25f];
    });
    
    [[UIApplication sharedApplication].keyWindow addSubview:galleryView];
}



+ (instancetype)sharedGalleryShowView
{
    static ELKGalleryShowView *galleryShowView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        galleryShowView = [[[self class] alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return galleryShowView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, ELKScreenWidth, ELKScreenHeight)];
        [self.scrollView setBackgroundColor:[UIColor clearColor]];
        self.scrollView.delegate = self;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = YES;
        self.scrollView.bouncesZoom = YES;
        self.scrollView.zoomScale = 2.f;
        self.scrollView.minimumZoomScale = 1.f;
        self.scrollView.maximumZoomScale = 3.f;
        
        self.contView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, ELKScreenWidth, ELKScreenHeight)];
        self.contView.backgroundColor = [UIColor clearColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, ELKScreenWidth, ELKScreenHeight)];
        self.imageView.clipsToBounds = YES;
        [self.imageView setBackgroundColor:[UIColor clearColor]];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        [self.contView addSubview:self.imageView];
        [self.scrollView addSubview:self.contView];
        [self.scrollView setContentSize:CGSizeMake(ELKScreenWidth, ELKScreenHeight)];
        self.imgOriRect = self.imageView.frame;
        
        [self addSubview:self.scrollView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureAction:)];
        singleTap.numberOfTapsRequired = 1;
        [self.scrollView addGestureRecognizer:singleTap];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureAction:)];
        doubleTap.numberOfTapsRequired = 2;
        [self.scrollView addGestureRecognizer:doubleTap];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
    }
    return self;
}

+ (void)adjustGalleryImgView:(CGSize)imgSize duration:(CGFloat)duration
{
    CGFloat imgZoomScale = 1.f;
    if (imgSize.width && imgSize.height) {
        imgZoomScale = 1.f * imgSize.width / imgSize.height;
    }
    CGFloat scrScale = 1.f * ELKScreenWidth /  ELKScreenHeight;
    CGFloat imgLocX = 0.f;
    CGFloat imgLocY = 0.f;
    CGFloat imgWidth = ELKScreenWidth;
    CGFloat imgHeight = ELKScreenHeight;
    if (imgZoomScale < scrScale) {
        imgWidth = ELKScreenHeight * imgZoomScale;
        imgLocX = (ELKScreenWidth - imgWidth) / 2.f;
    } else {
        imgHeight = ELKScreenWidth / imgZoomScale;
        imgLocY = (ELKScreenHeight - imgHeight) / 2.f;
    }
    
    [UIView animateWithDuration:duration animations:^{
        ELKGalleryShowView *galleryView = [self sharedGalleryShowView];
        galleryView.imageView.frame = CGRectMake(imgLocX, imgLocY, imgWidth, imgHeight);
        [galleryView setBackgroundColor:ELK_HexColor(0x000000, 1.f)];
    }];
    
}

- (void)dismissGalleryView
{
    [UIView animateWithDuration:0.2f animations:^{
        self.imageView.frame = CGRectMake(self.imgOriRect.origin.x, self.imgOriRect.origin.y, self.imgOriRect.size.width, self.imgOriRect.size.height);
        [self setBackgroundColor:ELK_HexColor(0x000000, 0.02f)];
    } completion:^(BOOL finished) {
        [self.imageView setImage:[UIImage new]];
        [self removeFromSuperview];
    }];
    
}

#pragma mark - 手势
- (void)singleTapGestureAction:(UIGestureRecognizer *)recoginzer
{
    [self.scrollView setZoomScale:1.f animated:NO];
    [self dismissGalleryView];
}
- (void)doubleTapGestureAction:(UIGestureRecognizer *)recognizer
{
    CGFloat contZoomScale = 2.f;
    if (self.scrollView.zoomScale >= 2.f) {
        contZoomScale = 1.f;
    }
    [self.scrollView setZoomScale:contZoomScale animated:YES];
}

#pragma mark - scrollView Zoom
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self adjustImgViewZoom];
}

- (void)adjustImgViewZoom
{
    CGSize imgSize = self.imageView.frame.size;
    
    CGFloat imgWidth = imgSize.width;
    CGFloat imgHeight = imgSize.height;
    CGFloat imgLocX = 0.f;
    CGFloat imgLocY = 0.f;
    if (imgWidth < ELKScreenWidth) {
        imgLocX = (ELKScreenWidth - imgWidth) / 2.f;
    }
    if (imgHeight < ELKScreenHeight) {
        imgLocY = (ELKScreenHeight - imgHeight) / 2.f;
    }
    
    self.imageView.frame = CGRectMake(imgLocX, imgLocY, imgWidth, imgHeight);
}


@end
