//
//  ViewController.m
//  数据持久化总结
//
//  Created by 许明洋 on 2020/8/10.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *NSUserDefaultWriteButton;
@property (nonatomic, strong) UIButton *NSUserDefaultReadButton;

@property (nonatomic, strong) UIButton *archiveButton;
@property (nonatomic, strong) UIButton *unarchiveButton;
@property (nonatomic, strong) Person *person;
@property (nonatomic, copy) NSString *documentPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"数据持久化总结";
    self.navigationController.navigationBar.translucent = NO;
    self.person =  [[Person alloc] init];
    
    [self.view addSubview:self.NSUserDefaultWriteButton];
    [self.NSUserDefaultWriteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.width.greaterThanOrEqualTo(@0);
        make.height.equalTo(@30);
    }];
    [self.view addSubview:self.NSUserDefaultReadButton];
    [self.NSUserDefaultReadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.NSUserDefaultWriteButton.mas_bottom).offset(20);
        make.width.greaterThanOrEqualTo(@0);
        make.height.equalTo(@30);
    }];
    
    [self.view addSubview:self.archiveButton];
    [self.archiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.NSUserDefaultReadButton.mas_bottom).offset(20);
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

#pragma mark - NSUserDefault 存储数据
- (UIButton *)NSUserDefaultWriteButton {
    if (_NSUserDefaultWriteButton) {
        return _NSUserDefaultWriteButton;
    }
    _NSUserDefaultWriteButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _NSUserDefaultWriteButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_NSUserDefaultWriteButton setTitle:@"NSUserDefault写入数据" forState:UIControlStateNormal];
    [_NSUserDefaultWriteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_NSUserDefaultWriteButton addTarget:self action:@selector(nsUserDefaultWirteData) forControlEvents:UIControlEventTouchUpInside];
    return _NSUserDefaultWriteButton;
}

- (UIButton *)NSUserDefaultReadButton {
    if (_NSUserDefaultReadButton) {
        return _NSUserDefaultReadButton;
    }
    _NSUserDefaultReadButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _NSUserDefaultReadButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_NSUserDefaultReadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_NSUserDefaultReadButton setTitle:@"NSUserDefault读出数据" forState:UIControlStateNormal];
    [_NSUserDefaultReadButton addTarget:self action:@selector(nsUserDefaultReadData) forControlEvents:UIControlEventTouchUpInside];
    return _NSUserDefaultReadButton;
}

- (void)nsUserDefaultWirteData {
    NSLog(@"NSUserDefault写入数据");
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:111 forKey:@"INT"];
    NSNumber *num = [NSNumber numberWithInteger:100];
    [ud setObject:num forKey:@"NUM"];
    [ud setBool:YES forKey:@"BOOL"];
    [ud setFloat:1.8 forKey:@"float"];
    [ud setObject:@"许明洋" forKey:@"Name"];
    NSArray *array = [NSArray arrayWithObjects:@"11",@"22",@"33",nil];
    [ud setObject:array forKey:@"ARRAY"];
    NSLog(@"写入数据结束");
}

- (void)nsUserDefaultReadData {
    NSLog(@"NSUserDefault读出数据");
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *name = [ud objectForKey:@"Name"];
    NSLog(@"从NSUserDefaults中读取的名字为%@",name);
    
    NSString *path = NSTemporaryDirectory();
    NSLog(@"数据持久化的路径为:%@",path);
}

#pragma mark - 归档/解档
- (UIButton *)archiveButton {
    if (_archiveButton) {;
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

- (void)archiveData {
    NSLog(@"开始归档数据");
    [self.person setName:@"许明洋" age:24];
    NSMutableData *mutableData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    [archiver encodeObject:self.person forKey:@"person"];
    [archiver finishEncoding];
    
    //将归档数据写入Library/Application Support/Data目录
    NSString *filePath = [self.documentPath stringByAppendingPathComponent:@"Data"];
    if (![mutableData writeToFile:filePath atomically:YES]) {
        NSLog(@"写入失败");
    }
    NSLog(@"结束归档数据");
}

- (void)unarchiveData {
    NSLog(@"开始解档数据");
    NSString *filePath = [self.documentPath stringByAppendingPathComponent:@"Data"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.person = [unarchiver decodeObjectForKey:@"person"];
    [unarchiver finishDecoding];
    
    NSLog(@"解档后得到的姓名为%@,年龄为%ld",self.person.name,(long)self.person.age);
    NSLog(@"结束解档数据");
}

- (NSString *)documentPath {
    if (_documentPath == nil) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        if (paths.count > 0) {
            _documentPath = paths.firstObject;
            
            //如果目录不存在,则创建目录
            if (![[NSFileManager defaultManager] fileExistsAtPath:_documentPath]) {
                
                NSError *error;
                //创建该目录
                if (![[NSFileManager defaultManager] createDirectoryAtPath:_documentPath withIntermediateDirectories:YES attributes:nil error:&error]) {
                    
                    NSLog(@"Failed to create dircetory. error:%@",error);
                }
            }
            
        }
    }
    NSLog(@"归档路径为：%@",_documentPath);
    return _documentPath;
}

@end
