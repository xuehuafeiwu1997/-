//
//  DBHelper.h
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/10.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <fmdb/FMDatabase.h>
#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBHelper : NSObject

//获取所有的名字
+ (id)getAllName;

//删除数据
+ (BOOL)delete:(Student *)student;

//将数据存储在FMDataBase中
+ (void)saveObject:(Student *)student;

//存储多条数据进入表中
+ (void)saveObjects:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
