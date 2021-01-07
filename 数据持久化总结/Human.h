//
//  Human.h
//  数据持久化总结
//
//  Created by 许明洋 on 2021/1/6.
//  Copyright © 2021 许明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Human : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;


@end

NS_ASSUME_NONNULL_END
