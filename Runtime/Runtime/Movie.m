//
//  Movie.m
//  Runtime
//
//  Created by 焦相如 on 9/30/16.
//  Copyright © 2016 jaxer. All rights reserved.
//

#import "Movie.h"
#import <objc/runtime.h>
#import "Macro.h"

@implementation Movie

// 一般写法
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_movieId forKey:@"id"];
//    [aCoder encodeObject:_movieName forKey:@"name"];
//    [aCoder encodeObject:_movieId forKey:@"url"];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        self.movieId = [aDecoder decodeObjectForKey:@"id"];
//        self.movieName = [aDecoder decodeObjectForKey:@"name"];
//        self.pic_url = [aDecoder decodeObjectForKey:@"url"];
//    }
//    return self;
//}

//runtime 实现方式
- (void)encodeWithCoder:(NSCoder *)aCoder
{
//    encodeRuntime(Movie) //抽象成宏之后的使用方法
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Movie class], &count);
    for (int i=0; i<count; i++) {
        const char *name = ivar_getName(ivars[i]);
        
        //归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
//    initCoderRuntime(aDecoder) //抽象成宏之后的使用方法
    
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Movie class], &count);
        for (int i=0; i<count; i++) {
            const char *name = ivar_getName(ivars[i]);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key]; //设置到成员变量身上
        }
        free(ivars);
    }
    return self;
}

@end
