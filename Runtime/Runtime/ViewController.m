//
//  ViewController.m
//  Runtime
//
//  Created by 焦相如 on 9/30/16.
//  Copyright © 2016 jaxer. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "NSObject+Name.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self copyPropertyList];
//    [self copyMethodList];
    [self copyIvarList];
//    [self copyProtocolList];
//    [self methodSwizzling];
    [self associatedObject];
}

/**
 *  获取属性列表
 */
- (void)copyPropertyList
{
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([NSObject class], &count);
    for (int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property--->%@", [NSString stringWithUTF8String:propertyName]);
    }
}

/**
 *  获取方法列表
 */
- (void)copyMethodList
{
    unsigned int count;
    Method *methodList = class_copyMethodList([UIView class], &count);
    for (int i=0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method--->%@", NSStringFromSelector(method_getName(method)));
    }
}

/**
 *  获取实例变量列表
 */
- (void)copyIvarList
{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([UIViewController class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar); //获取变量名
        const char *ivarType = ivar_getTypeEncoding(ivar); //获取变量编码类型
        NSLog(@"Ivar--->%s - %s", ivarName, ivarType);
        
        NSString *str = [NSString stringWithUTF8String:ivarName];
        if ([str isEqualToString:@"_title"]) { //若有_title实例变量，则给它赋值
            object_setIvar(self, ivar, @"hello");
        }
    }
    NSLog(@"_title = %@", self.title);
    
//    [ViewController initialize];
}

/**
 *  获取协议列表
 */
- (void)copyProtocolList
{
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([UITableView class], &count);
    for (int i=0; i<count; i++) {
        const char *protocolName = protocol_getName(protocolList[i]);
        NSLog(@"Protocol--->%@", [NSString stringWithUTF8String:protocolName]);
    }
}

/**
 *  方法交换
 */
- (void)methodSwizzling
{
    [UIImage imageNamed:@"test"]; //这里调用的是交换后的方法，因此会打印出是否加载成功
}

/**
 *  动态关联属性
 */
- (void)associatedObject
{
    NSObject *obj = [[NSObject alloc] init];
    obj.name = @"Jack"; //这是添加的属性
    NSLog(@"name is %@", obj.name);
    
    NSArray *arr = [[NSArray alloc] init];
    arr.name = @"Array";
    NSLog(@"array is %@", arr.name);
}

@end
