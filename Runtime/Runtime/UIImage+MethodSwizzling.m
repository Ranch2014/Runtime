//
//  UIImage+MethodSwizzling.m
//  Runtime
//
//  Created by 焦相如 on 9/30/16.
//  Copyright © 2016 jaxer. All rights reserved.
//

#import "UIImage+MethodSwizzling.h"
#import <objc/runtime.h>

@implementation UIImage (MethodSwizzling)

+ (void)load
{
    //获取两个方法
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method currentImageNamedMethod = class_getClassMethod(self, @selector(currentImageNamed:));
    
    //方法交换
    method_exchangeImplementations(imageNamedMethod, currentImageNamedMethod);
}

+ (UIImage *)currentImageNamed:(NSString *)name
{
    //程序执行到这里时，两个方法已经交换过了
    UIImage *image = [UIImage currentImageNamed:name];
    
    if (image) {
        NSLog(@"加载成功");
    } else {
        NSLog(@"加载失败");
    }
    
    return image;
}

@end
