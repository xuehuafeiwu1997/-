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

+ (id)getDataWithKey:(NSString *)key {
    NSString *searchSql = nil;
    FMResultSet *set = nil;
//    if (key.length > 0) {
//     searchSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ?",kTableName,kColumnID];
//        set = [db executeQuery:searchSql,key];
//    } else {
//        searchSql = [NSString stringWithFormat:@"SELECT * FROM %@",kTableName];
//        set = [db executeQuery:searchSql];
//    }
    searchSql = [NSString stringWithFormat:@"SELECT * FROM %@",kTableName];
    set = [db executeQuery:searchSql];
    //执行sql语句，在FMDB中，除了查询语句使用executQuery外，其余的增删改查都使用executeUpdate来实现。
    while (set.next) {
        NSString *name = [set stringForColumn:@"name"];
        NSLog(@"根据当前的查询得到名字为:%@",name);
        NSString *college = [set stringForColumnIndex:1];
        NSLog(@"第一个是%@",college);
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

+ (BOOL)delete:(Student *)student {
    BOOL success = YES;
//    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ? AND %@ = ? AND %@ = ? AND %@ = ? AND %@ = ?",kTableName,kColumnID,kColumnName,kColumnCollege,kColumnUniversity,kColumnAge];
//     BOOL isCan = [db executeUpdate:deleteSql,student.id,student.name,student.college,student.university,@(student.age)];
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
