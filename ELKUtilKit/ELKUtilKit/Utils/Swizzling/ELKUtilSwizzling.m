//
//  ELKUtilSwizzling.m
//  ELKUtilKit
//
//  Created by wing on 2019/7/4.
//  Copyright © 2019 wing. All rights reserved.
//

#import "ELKUtilSwizzling.h"

@implementation ELKUtilSwizzling


+ (void)exchangeMethodWithClass:(id)objClass oriMethod:(SEL)oriSel newMethod:(SEL)newSel
{
    Method fromMethod = class_getInstanceMethod([objClass class], oriSel);
    Method toMethod = class_getInstanceMethod([objClass class], newSel);
    
    if (!class_addMethod([objClass class], oriSel, method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
    
}





@end
