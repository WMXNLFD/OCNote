//
//  LoginViewController.m
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/8.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+Hex.h"
#import "MBProgressHUD+NJ.h"
#import "ListViewController.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
//@property (weak, nonatomic) UITextField *username1Field;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //代理实现监听文本框
//    self.usernameField.delegate = self;
    
    // 监听文本框
    [self.usernameField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];

    // 判断登录 是不是正确 正确跳转页面 错误显示错误的提示框 监听登录按钮
    [self.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
        
//    UITextField *a = [[UITextField alloc] init];
//    self.username1Field = a;
//    [self.view addSubview:a];
}

// 登录按钮的点击事件
- (void)login:(UIButton *)sender {
    
    // 显示正在登录
    [MBProgressHUD showMessage:@"正在登录"];

    // 延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 服务器有返回 隐藏
        [MBProgressHUD hideHUD];
        // 账号和密码正确 进行跳转
        if([self.usernameField.text isEqualToString:@"1"] && [self.passwordField.text isEqualToString:@"1"]){
            // login 跳转 list  使用 segue
            [self performSegueWithIdentifier:@"login2list" sender:nil];
        }else{
            [MBProgressHUD showError:@"账号或密码错误"];
            self.messageLabel.text = @"账号或密码错误";
        }
        
    });
}

// 只要走sb 的线 都会调用 自动调用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ListViewController *contact = segue.destinationViewController;
    contact.username = self.usernameField.text;
}

// 文本框内容发生改变的时候调用
- (void)textChange:(UITextField*)sender {
    
//    NSLog(@"%@", self.usernameField.text);
    if (self.usernameField.text.length > 0 && self.passwordField.text.length > 0) {
        // 两个文本框都有内容
        self.loginButton.enabled = YES;
        // 设置loginButon 颜色
        self.loginButton.backgroundColor = [UIColor colorWithHexString:@"36B59D"];
    } else {
        // 两个文本框都没有内容
        self.loginButton.enabled = NO;
        self.loginButton.backgroundColor = [UIColor colorWithHexString:@"E5E5E5"];
    }
}

@end
