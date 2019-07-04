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
 朋友圈风格展示放大图片
 
 @param imageUrl 图片URL
 @param imgName  占位图名字
 @param imgView  当前显示图片的视图
 */
+ (void)showGallery:(nullable NSString *)imageUrl placeHolderName:(nullable NSString *)imgName imgView:(nonnull UIView *)imgView;


/**
 朋友圈风格展示放大图片

 @param imageUrl   图片URL
 @param placeImage 占位图
 @param imgView    当前显示图片的视图
 */
+ (void)showGallery:(nullable NSString *)imageUrl placeHolder:(nullable UIImage *)placeImage imgView:(nonnull UIView *)imgView;


/**
 朋友圈风格展示放大图片

 @param imgName 本地图片名字
 @param imgView 当前显示图片的视图
 */
+ (void)showGallery:(nullable NSString *)imgName imgView:(nonnull UIView *)imgView;


/**
 朋友圈风格展示放大图片

 @param image   图片UIImage
 @param imgView 当前显示图片的视图
 */
+ (void)showGalleryImg:(nullable UIImage *)image imgView:(nonnull UIView *)imgView;



@end

NS_ASSUME_NONNULL_END
