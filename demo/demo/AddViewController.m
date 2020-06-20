//
//  AddViewController.m
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/9.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import "AddViewController.h"
#include "UIColor+Hex.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *tagsField;
//@property (weak, nonatomic) IBOutlet UITextField *contentField;
@property (weak, nonatomic) IBOutlet UITextView *contentField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectSeg;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 实时监听两个文本框的内容的变化
    [self.tagsField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
//    [self.contentField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    // 监听保存按钮的点击事件
    self.saveButton.action = @selector(addClick);
    
    //让 姓名文本框 成为第一响应者
    [self.tagsField becomeFirstResponder];
    
    // 修改 selectSeg字体颜色
//    self.selectSeg.tintColor = [UIColor colorWithHexString:@"FFFFFF"];
//    self.selectSeg.selectedSegmentTintColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self.selectSeg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"FFFFFF"]} forState:UIControlStateSelected];
   
    
}

// 保存按钮的点击事件
-(void)addClick{
    NSLog(@"addClick");
    
    // 判断代理方法是不是能够响应
    if([self.deldgate respondsToSelector:@selector(addViewController:withNote:)]){
        // 如果可以响应  那么执行代理方法
        
        //创建一个模型
        Note *note = [[Note alloc] init];
        note.tagsText = self.tagsField.text;
        note.contentText = self.contentField.text;
        if(self.selectSeg.selectedSegmentIndex == 0) {
            NSLog(@"AddViewController 选择了私有");
            note.priOrPubSeg = @"私";
        } else {
            NSLog(@"AddViewController 选择了公有");
            note.priOrPubSeg = @"公";
        }
        
        [self.deldgate addViewController:self withNote:note];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 文本框中文本发生改变的时候调用
-(void)textChange{
//    NSLog(@"AddViewController textchange");
//    self.saveButton.enabled = self.tagsField.text.length > 0 && self.contentField.text.length > 0;
     self.saveButton.enabled = self.tagsField.text.length > 0 && self.contentField.text.length > 0;
}

// 监听segment 控件的变化
- (IBAction)segmentChange:(UISegmentedControl *)sender {
    // 选择的分段
    NSLog(@"AddViewController segmentChange %ld", (long)sender.selectedSegmentIndex);
}

@end
