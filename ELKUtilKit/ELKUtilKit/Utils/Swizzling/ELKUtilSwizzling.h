//
//  ELKUtilSwizzling.h
//  ELKUtilKit
//
//  Created by wing on 2019/7/4.
//  Copyright © 2019 wing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELKUtilSwizzling : NSObject


// exchange two methods of class
+ (void)exchangeMethodWithClass:(id)objClass oriMethod:(SEL)oriSel newMethod:(SEL)newSel;




@end

NS_ASSUME_NONNULL_END
