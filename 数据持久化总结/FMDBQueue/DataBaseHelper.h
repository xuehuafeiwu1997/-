//
//  DataBaseHelper.h
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/11.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <fmdb/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataBaseHelper : NSObject

+ (void)batchUpdate:(void(^)(FMDatabase *db))block;

+ (NSArray *)getRows:(NSString *)sql, ...;

@end

NS_ASSUME_NONNULL_END
