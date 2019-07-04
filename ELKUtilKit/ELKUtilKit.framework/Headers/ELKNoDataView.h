//
//  ELKNoDataView.h
//  ScrapMaster
//
//  Created by BNT-FS01 on 2017/12/6.
//  Copyright © 2017年 BNT-FS01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELKNoDataView : UIView


/**
 Initializes and returns a newly allocated view object with the specified image name, and specified remind text.
 
 @param imgName Nodata Image Name
 @param remind  Nodata Remind Text
 @return        ELKNoDataView Object
 */
+ (nonnull instancetype)noDataWithImgName:(nullable NSString *)imgName remind:(nullable NSString *)remind;


/**
 Initializes and returns a newly allocated view object with the specified image, and specified remind text.

 @param image   Nodata Image
 @param remind  Nodata Remind Text
 @return        ELKNoDataView Object
 */
+ (nonnull instancetype)noDataWithImage:(nullable UIImage *)image remind:(nullable NSString *)remind;







@end
