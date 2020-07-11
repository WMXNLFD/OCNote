//
//  ViewController.m
//  CustomTag
//
//  Created by za4tech on 2017/12/15.
//  Copyright © 2017年 Junior. All rights reserved.
//

#import "ViewController.h"
#import "TagView.h"
#define kScreenWidth      [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<TagViewDelegate>
@property (nonatomic ,strong)TagView * tagView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tagView];
    self.tagView.arr = @[@"锤子",@"见过",@"膜拜单车",@"微信支付",@"Q",@"王者荣耀",@"蓝淋网",@"阿珂",@"半生",@"猎场",@"QQ空间",@"王者荣耀助手",@"斯卡哈复健科",@"安抚",@"沙发上",@"日打的费",@"问问",@"无人区",@"阿斯废弃物人情味",@"沙发上",@"日打的费",@"问问",@"无人区",@"阿斯废弃物人情味",@"沙发上",@"日打的费",@"问问",@"无人区",@"阿斯废弃物人情味",@"沙发上",@"日打的费",@"问问",@"无人区",@"阿斯废弃物人情味"];
}

-(TagView *)tagView{
    if (!_tagView) {
        _tagView = [[TagView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 0)];
        _tagView.backgroundColor = [UIColor greenColor];
        _tagView.delegate = self;
    }
    return _tagView;
}

#pragma mark - CCTagViewDelegate
-(void)handleSelectTag:(NSString *)keyWord{
    NSLog(@"keyWord ---- %@",keyWord);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
