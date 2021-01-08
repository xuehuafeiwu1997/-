//
//  ArchiveViewController.m
//  数据持久化总结
//
//  Created by 许明洋 on 2021/1/6.
//  Copyright © 2021 许明洋. All rights reserved.
//

#import "ArchiveViewController.h"
#import "Masonry.h"
#import "Human.h"

@interface ArchiveViewController ()

@property (nonatomic, strong) UIButton *archiveButton;
@property (nonatomic, strong) UIButton *unarchiveButton;
@property (nonatomic, copy) NSString *path1;
@property (nonatomic, copy) NSString *path2;

@end

@implementation ArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"归档解档实现";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.archiveButton];
    [self.archiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.greaterThanOrEqualTo(@0);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.unarchiveButton];
    [self.unarchiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.archiveButton.mas_bottom).offset(20);
        make.width.greaterThanOrEqualTo(@0);
        make.height.equalTo(@30);
    }];
}

- (void)archiveData {
    NSLog(@"开始归档数据");
    Human *human = [[Human alloc] init];
    human.name = @"落叶兮兮";
    human.age = 24;

    //第一种方法，使用NSKeyArchiver类方法，将对象转化为NSData，然后写入指定的文件中
    NSError *error = nil;
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:human requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"归档失败，失败的原因是%@",error);
    }
    

    BOOL success = [data1 writeToFile:self.path1 atomically:YES];
    if (success) {
        NSLog(@"写入成功");
    } else {
        NSLog(@"写入失败");
    }
    
    //第二种使用NSKeyArchiver的实例方法,编码时使用相应的键值，然后将编码后的数据写入执行的路径中
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initRequiringSecureCoding:YES];
    [archiver encodeObject:human forKey:@"Human"];
    [archiver finishEncoding];
    NSLog(@"NSKeyArchiver编码的数据为%@",archiver.encodedData);
    [archiver.encodedData writeToFile:self.path2 atomically:YES];
    NSLog(@"归档结束");
    
    
}

- (void)unarchiveData {
    NSLog(@"开始解档数据");
    //使用NSKeyedUnarchiver类方法解析
    NSData *data1 = [NSData dataWithContentsOfFile:self.path1];
    NSError *error1 = nil;
    Human *human1 = [NSKeyedUnarchiver unarchivedObjectOfClass:[Human class] fromData:data1 error:&error1];
    if (error1) {
        NSLog(@"解档数据失败,失败的原因是%@",error1);
    } else {
        NSLog(@"解档数据成功");
        NSLog(@"human name = %@,age = %ld",human1.name,human1.age);
    }
    
    //使用NSKeyedUnarchiver实例方法解析
    NSError *error2 = nil;
    NSData *data2 = [NSData dataWithContentsOfFile:self.path2];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data2 error:&error2];
    Human *human2 = [unarchiver decodeObjectOfClass:[Human class] forKey:@"Human"];
    [unarchiver finishDecoding];
    if (error2) {
        NSLog(@"解档数据失败,失败的原因是%@",error2);
    } else {
        NSLog(@"解档数据成功");
        NSLog(@"human name = %@,age = %ld",human2.name,human2.age);
    }
}

#pragma mark - 归档/解档
- (NSString *)path1 {
    if (_path1) {
        return _path1;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    _path1 = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Data1"];
    NSLog(@"path1 = %@",_path1);
    return _path1;
}

- (NSString *)path2 {
    if (_path2) {
        return _path2;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    _path2 = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Data2"];
    NSLog(@"path2 = %@",_path2);
    return _path2;
}

- (UIButton *)archiveButton {
    if (_archiveButton) {
        return _archiveButton;
    }
    _archiveButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _archiveButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_archiveButton setTitle:@"归档" forState:UIControlStateNormal];
    [_archiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_archiveButton addTarget:self action:@selector(archiveData) forControlEvents:UIControlEventTouchUpInside];
    return _archiveButton;
}

- (UIButton *)unarchiveButton {
    if (_unarchiveButton) {
        return _unarchiveButton;
    }
    _unarchiveButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _unarchiveButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_unarchiveButton setTitle:@"解档" forState:UIControlStateNormal];
    [_unarchiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_unarchiveButton addTarget:self action:@selector(unarchiveData) forControlEvents:UIControlEventTouchUpInside];
    return _unarchiveButton;
}

@end
