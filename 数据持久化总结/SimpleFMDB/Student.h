//
//  Student.h
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/11.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *college;//学院
@property (nonatomic, copy) NSString *university;
@property (nonatomic, assign) NSInteger age;

@end

NS_ASSUME_NONNULL_END
