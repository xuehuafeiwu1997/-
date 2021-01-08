//
//  FMDBViewController.m
//  数据持久化总结
//
//  Created by 许明洋 on 2021/1/7.
//  Copyright © 2021 许明洋. All rights reserved.
//

#import "FMDBViewController.h"
#import "Student.h"
#import "DBHelper.h"
#import "Masonry.h"

@interface FMDBViewController ()

@property (nonatomic, strong) UIButton *dbSaveButton;
@property (nonatomic, strong) UIButton *dbReadButton;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) Student *student;


@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"FMDB存储数据";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.dbSaveButton];
    [self.dbSaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.greaterThanOrEqualTo(@0);
        make.height.equalTo(@30);
    }];
    [self.view addSubview:self.dbReadButton];
    [self.dbReadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.dbSaveButton.mas_bottom).offset(20);
        make.width.greaterThanOrEqualTo(@0);
        make.height.equalTo(@30);
    }];
    
    //初始化数据
    [self initStudent];
}

- (void)initStudent {
    self.array = [NSMutableArray array];
    
    Student *student1 = [[Student alloc] init];
    student1.id = @"1234567";
    student1.name = @"落叶兮兮";
    student1.college = @"学院1";
    student1.university = @"大学1";
    student1.age = 23;
    [self.array addObject:student1];
    
    Student *student2 = [[Student alloc] init];
    student2.id = @"1245467767";
    student2.name = @"雪花飞舞";
    student2.college = @"学院1";
    student2.university = @"大学2";
    student2.age = 23;
    [self.array addObject:student2];
}

- (UIButton *)dbSaveButton {
    if (_dbSaveButton) {
        return _dbSaveButton;
    }
    _dbSaveButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _dbSaveButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_dbSaveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_dbSaveButton setTitle:@"FMDataBase存储数据" forState:UIControlStateNormal];
    [_dbSaveButton addTarget:self action:@selector(fmDataBaseSaveData) forControlEvents:UIControlEventTouchUpInside];
    return _dbSaveButton;
}

- (UIButton *)dbReadButton {
    if (_dbReadButton) {
        return _dbReadButton;
    }
    _dbReadButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _dbReadButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [_dbReadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_dbReadButton setTitle:@"FMDataBase读取数据" forState:UIControlStateNormal];
    [_dbReadButton addTarget:self action:@selector(fmDataBaseReadData) forControlEvents:UIControlEventTouchUpInside];
    return _dbReadButton;
}

- (void)fmDataBaseSaveData {
    NSLog(@"FMDB存储数据");
    [DBHelper saveObjects:self.array];
}

- (void)fmDataBaseReadData {
    NSLog(@"FMDB读取数据");
    Student *student = [self.array objectAtIndex:0];
    [DBHelper getDataWithKey:student.name];
}

@end
