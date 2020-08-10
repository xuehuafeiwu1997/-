//
//  Person.m
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/10.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

- (void)setName:(NSString *)name age:(NSInteger)age {
    self.name = name;
    self.age = age;
}

//1.编码方法
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"PersonName"];
    [aCoder encodeInteger:self.age forKey:@"PersonAge"];
}

//2.解码方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"PersonName"];
        self.age = [aDecoder decodeIntegerForKey:@"PersonAge"];
    }
    return self;
}

@end
