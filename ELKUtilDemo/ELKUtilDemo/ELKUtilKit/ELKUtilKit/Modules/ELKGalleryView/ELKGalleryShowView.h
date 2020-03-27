//
//  ELKGalleryShowView.h
//  ELKUtilKit
//
//  Created by wing on 2018/12/21.
//  Copyright © 2018 wing. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELKGalleryShowView : UIView


/**
 Full screen preview picture
 
 @param imageUrl Picture URL
 @param imgName  Placeholder Image's name
 @param imgView  The view that currently displays the image
 */
+ (void)showGallery:(nullable NSString *)imageUrl placeHolderName:(nullable NSString *)imgName imgView:(nonnull UIView *)imgView;


/**
 Full screen preview picture

 @param imageUrl   Picture URL
 @param placeImage Placeholder Image
 @param imgView    The view that currently displays the image
 */
+ (void)showGallery:(nullable NSString *)imageUrl placeHolder:(nullable UIImage *)placeImage imgView:(nonnull UIView *)imgView;


/**
 Full screen preview picture, use default placeholder image

 @param imgName Local Image's name
 @param imgView The view that currently displays the image
 */
+ (void)showGallery:(nullable NSString *)imgName imgView:(nonnull UIView *)imgView;


/**
 Full screen preview picture, use default placeholder image

 @param image   UIImage object
 @param imgView The view that currently displays the image
 */
+ (void)showGalleryImg:(nullable UIImage *)image imgView:(nonnull UIView *)imgView;



@end

NS_ASSUME_NONNULL_END
