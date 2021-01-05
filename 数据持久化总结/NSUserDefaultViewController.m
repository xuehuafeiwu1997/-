//
//  NSUserDefaultViewController.m
//  数据持久化总结
//
//  Created by 许明洋 on 2020/12/17.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "NSUserDefaultViewController.h"
#import "Masonry.h"

@interface NSUserDefaultViewController ()

@property (nonatomic, strong) UIButton *NSUserDefaultWriteButton;
@property (nonatomic, strong) UIButton *NSUserDefaultReadButton;

@end

@implementation NSUserDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NSUserDefault存储";
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.NSUserDefaultWriteButton];
    [self.NSUserDefaultWriteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
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
}

- (void)nsUserDefaultWirteData {
    NSLog(@"NSUserDefault写入数据");
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:111 forKey:@"INT"];
    NSNumber *num = [NSNumber numberWithInteger:100];
    [ud setObject:num forKey:@"NUM"];
    [ud setBool:YES forKey:@"BOOL"];
    [ud setFloat:1.8 forKey:@"float"];
    [ud setObject:@"落叶兮兮" forKey:@"Name"];
    NSArray *array = [NSArray arrayWithObjects:@"11",@"22",@"33",nil];
    [ud setObject:array forKey:@"ARRAY"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"1" forKey:@"落叶兮兮"];
    [dic setValue:@"2" forKey:@"雪花飞舞"];
    [ud setObject:dic forKey:@"Dictionary"];
    NSLog(@"写入数据结束");
    
    //NSUserDefault写入数据，默认放在library/Preferences文件夹下，以.plist文件存放
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"数据持久化的路径为：%@",path);
}

- (void)nsUserDefaultReadData {
    NSLog(@"NSUserDefault读出数据");
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *name = [ud objectForKey:@"Name"];
    NSLog(@"name = %@",name);
    
    NSArray *arr = [ud objectForKey:@"ARRAY"];
    NSLog(@"arr = %@",arr);
    
    NSDictionary *dic = [ud objectForKey:@"Dictionary"];
    NSLog(@"dic = %@",dic);
    
    NSLog(@"读取数据结束");
}

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

@end
