//
//  NSObject+Name.m
//  Runtime
//
//  Created by 焦相如 on 9/30/16.
//  Copyright © 2016 jaxer. All rights reserved.
//

#import "NSObject+Name.h"
#import <objc/runtime.h>

@implementation NSObject (Name)

- (void)setName:(NSString *)name
{
//    self.name = name; //这样不行
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_COPY_NONATOMIC); //OK
}

- (NSString *)name
{
//    return self.name; //这样不行
    return objc_getAssociatedObject(self, "name"); //OK
}

@end
