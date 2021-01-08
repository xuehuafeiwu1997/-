//
//  Human.m
//  数据持久化总结
//
//  Created by 许明洋 on 2021/1/6.
//  Copyright © 2021 许明洋. All rights reserved.
//

#import "Human.h"

@implementation Human

+ (BOOL)supportsSecureCoding {
    return YES;
}

//1.编码方法
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"HumanName"];
    [coder encodeInteger:self.age forKey:@"HumanAge"];
}

//2.解码方法
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"HumanName"];
        self.age = [coder decodeIntegerForKey:@"HumanAge"];
    }
    return self;
}

@end

