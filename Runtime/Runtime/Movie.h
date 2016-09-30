//
//  Movie.h
//  Runtime
//
//  Created by 焦相如 on 9/30/16.
//  Copyright © 2016 jaxer. All rights reserved.
//

#import <Foundation/Foundation.h>

//若想要当前类可以实现归档与反归档，需要遵守 NSCoding 协议
@interface Movie : NSObject <NSCoding>

@property (nonatomic, copy) NSString *movieId;
@property (nonatomic, copy) NSString *movieName;
@property (nonatomic, copy) NSString *pic_url;

@end
