//
//  DBHelper.m
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/10.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "DBHelper.h"
#import "FCFileManager.h"

static NSString * const dbName = @"app.db";//数据库名称
static FMDatabase *db;//先不使用FMDataBaseQueue，直接使用FMDataBase

static NSString * const kTableName = @"Student";
static NSString * const kColumnID = @"id";
static NSString * const kColumnName = @"name";
static NSString * const kColumnCollege = @"college";
static NSString * const kColumnUniversity = @"university";
static NSString * const kColumnAge = @"age";

@implementation DBHelper

+ (NSString *)dbFilePath {
    return [FCFileManager pathForDocumentsDirectoryWithPath:dbName];
}

+ (void)initialize {
    NSLog(@"数据库的存储路径为:%@",[self dbFilePath]);
    db = [FMDatabase databaseWithPath:[self dbFilePath]];
    if (![db open]) {
        NSLog(@"数据库无法开启");
    }
    //创建表
    [self createTable:db];
}

+ (void)createTable:(FMDatabase *)db {
    NSString *createSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ("
                           "%@ TEXT,"
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
    BOOL success = [db executeUpdate:createSql];
    if (success) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
}

+ (id)getAllName {
    NSString *searchSql = nil;
    FMResultSet *set = nil;
    searchSql = [NSString stringWithFormat:@"SELECT * FROM %@",kTableName];
    set = [db executeQuery:searchSql];
    //执行sql语句，在FMDB中，除了查询语句使用executQuery外，其余的增删改查都使用executeUpdate来实现。
    int i = 0;
    while (set.next) {
        i++;
        NSString *name = [set stringForColumn:@"name"];
        NSLog(@"第%d个名字为:%@",i,name);
    }
    return @[];
}

+ (void)saveObject:(Student *)student {
    //如果原本已经存在了相同的，则应该将其删除
    [self delete:student];
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES(?,?,?,?,?)",kTableName,kColumnID,kColumnName,kColumnCollege,kColumnUniversity,kColumnAge];
    BOOL success = [db executeUpdate:insertSql,student.id,student.name,student.college,student.university,@(student.age)];
    
    if (success) {
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
    }
}

+ (void)saveObjects:(NSArray *)array {
    if (array.count <= 0) {
        NSLog(@"保存的数据不能为空");
        return;
    }
    for (int i = 0; i < array.count; i++) {
        Student *student = (Student *)[array objectAtIndex:i];
        if (student) {
            [self saveObject:student];
        }
    }
}

+ (BOOL)delete:(Student *)student {
    BOOL success = YES;
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",kTableName,kColumnID];
    BOOL isCan = [db executeUpdate:deleteSql,student.id];
    if (!isCan) {
        success = NO;
        NSLog(@"删除失败");
    } else {
        NSLog(@"删除成功");
    }
    return success;
}

@end
