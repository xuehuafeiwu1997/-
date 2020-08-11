//
//  studentDBHelper.h
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/11.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface studentDBHelper : NSObject

+ (void)insertStudentObject:(Student *)student;
+ (void)batchUpdateStudentObjects:(NSArray *)array;
+ (void)removeFavouriteObject:(Student *)student;
+ (void)removeFavouriteObjects:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
