//
//  NSUserDefaultViewController.m
//  数据持久化总结
//
//  Created by 许明洋 on 2020/12/17.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "NSUserDefaultViewController.h"
#import "Masonry.h"
#import "Person.h"

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
    
    //存储整数
    [ud setInteger:111 forKey:@"INT"];
    
    //存储NSNumber
    NSNumber *num = [NSNumber numberWithInteger:100];
    [ud setObject:num forKey:@"NUM"];
    
    //存储bool值
    [ud setBool:YES forKey:@"BOOL"];
    
    //存储浮点数
    [ud setFloat:1.8 forKey:@"float"];
    
    //存储字符串NSString
    [ud setObject:@"落叶兮兮" forKey:@"Name"];
    
    //存储数组
    NSArray *array = [NSArray arrayWithObjects:@"11",@"22",@"33",nil];
    [ud setObject:array forKey:@"ARRAY"];
    
    //存储字典NSDictionary
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"落叶兮兮" forKey:@"Id1"];
    [dic setValue:@"雪花飞舞" forKey:@"Id2"];
    [ud setObject:dic forKey:@"Dictionary"];
    
    //存储自定义对象
    Person *person = [[Person alloc] init];
    [person setName:@"落叶兮兮" age:24];
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"写入数据时转换失败，失败的原因是%@",error);
    }
    [ud setObject:data forKey:@"Person"];
    NSLog(@"写入数据结束");
    
    //NSUserDefault写入数据，默认放在library/Preferences文件夹下，以.plist文件存放
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"数据持久化的路径为：%@",path);
}

- (void)nsUserDefaultReadData {
    NSLog(@"NSUserDefault读出数据");
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //读取NSInteger
    NSInteger i = [[ud objectForKey:@"INT"] integerValue];
    NSLog(@"i = %ld",(long)i);
    
    //读取NSNumber
    NSNumber *number = [ud objectForKey:@"NUM"];
    NSLog(@"number = %@",number);
    
    //读取bool值
    BOOL isYES = [ud objectForKey:@"BOOL"];
    NSLog(@"isYES = %d",isYES);
    
    //读取浮点数
    CGFloat f = [[ud objectForKey:@"float"] floatValue];
    NSLog(@"f = %f",f);
    
    //读取NSString
    NSString *name = [ud objectForKey:@"Name"];
    NSLog(@"name = %@",name);
    
    //读取NSArray
    NSArray *arr = [ud objectForKey:@"ARRAY"];
    NSLog(@"arr = %@",arr);
    
    //读取NSDictionary
    NSDictionary *dic = [ud objectForKey:@"Dictionary"];
    NSLog(@"dic id1 = %@",[dic objectForKey:@"Id1"]);
    NSLog(@"dic id2 = %@",[dic objectForKey:@"Id2"]);
    
    //读取自定义对象Person
    NSData *data = [ud objectForKey:@"Person"];
    Person *person = [[Person alloc] init];
    NSError *error = nil;
    person = [NSKeyedUnarchiver unarchivedObjectOfClass:[Person class] fromData:data error:&error];
    if (error) {
        NSLog(@"转化出错，出错的原因为%@",error);
    }
    NSLog(@"person name = %@",person.name);
    NSLog(@"person age = %ld",(long)person.age);
    
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
