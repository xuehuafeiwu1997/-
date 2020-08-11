//
//  studentDBHelper.m
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/11.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "studentDBHelper.h"
#import "DataBaseHelper.h"

static NSString * const kTableName = @"Student";
static NSString * const kColumnID = @"id";
static NSString * const kColumnName = @"name";
static NSString * const kColumnCollege = @"college";
static NSString * const kColumnUniversity = @"university";
static NSString * const kColumnAge = @"age";

@implementation studentDBHelper

+ (void)initialize {
    [self createTable];
}

+ (void)createTable {
      NSString *createSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ("
                             "%@ TEXT PRIMARY KEY,"
                             "%@ TEXT,"
                             "%@ TEXT,"
                             "%@ TEXT,"
                             "%@ INTEGER)",
                             kTableName,
                             kColumnID,
                             kColumnName,
                             kColumnCollege,
                             kColumnUniversity,
                             kColumnAge
                             ];
    [DataBaseHelper batchUpdate:^(FMDatabase * _Nonnull db) {
        BOOL success = [db executeUpdate:createSql,nil];
        if (success) {
            NSLog(@"创建表格成功");
        } else {
            NSLog(@"创建表格失败");
        }
    }];
}

//插入单条数据
+ (void)insertStudentObject:(Student *)student {
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES(?,?,?,?,?)",kTableName,kColumnID,kColumnName,kColumnCollege,kColumnUniversity,kColumnAge];
    [DataBaseHelper batchUpdate:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:insertSql,student.id,student.name,student.college,student.university,@(student.age)];
    }];
}

//插入多条数据
+ (void)batchUpdateStudentObjects:(NSArray *)array {
    if ([array count] == 0) {
        return;
    }
   NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES(?,?,?,?,?)",kTableName,kColumnID,kColumnName,kColumnCollege,kColumnUniversity,kColumnAge];
    [DataBaseHelper batchUpdate:^(FMDatabase * _Nonnull db) {
        for (Student *student in array) {
            [db executeUpdate:insertSql,student.id,student.name,student.college,student.university,@(student.age)];
        }
    }];
}

+ (void)removeFavouriteObject:(Student *)student {
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",kTableName,kColumnID];
    [DataBaseHelper batchUpdate:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:deleteSql,student.id];
    }];
}

+ (void)removeFavouriteObjects:(NSArray *)array {
    if ([array count] == 0) {
        return;
    }
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",kTableName,kColumnID];
    [DataBaseHelper batchUpdate:^(FMDatabase * _Nonnull db) {
        for (Student *student in array) {
            [db executeUpdate:deleteSql,student.id];
        }
    }];
}

@end
