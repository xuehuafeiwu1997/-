//
//  Person.h
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/10.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (void)setName:(NSString *)name age:(NSInteger)age;

@end

NS_ASSUME_NONNULL_END
