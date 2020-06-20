//
//  EditViewController.m
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/9.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *editTags;
//@property (weak, nonatomic) IBOutlet UITextField *editContent;
@property (weak, nonatomic) IBOutlet UITextView *editContent;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editSeg;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置初始的文本框的内容（传过来的内容）
    self.editTags.text = self.note.tagsText;
    self.editContent.text = self.note.contentText;
    NSString *priOrPub = self.note.priOrPubSeg;
    if([priOrPub isEqualToString:@"私"]) {
        self.editSeg.selectedSegmentIndex = 0;
    } else {
        self.editSeg.selectedSegmentIndex = 1;
    }
    
}

// 右上角 保存按钮点击事件
- (IBAction)editClick:(UIBarButtonItem *)sender {
    // editTag 默认不能编辑
    if(!self.editTags.enabled){
        // 编辑显示的文字
        sender.title = @"保存";
        // 可以编辑 各控件enable 设为 YES
        self.editTags.enabled = YES;
        self.editContent.editable = YES;
        [self.editSeg setEnabled:YES];
    }else{
        // 查看列表显示的文字
        sender.title = @"编辑";
        // 查看列表 各控件enable 设为 NO
        self.editTags.enabled = NO;
        self.editContent.editable = NO;
//        [self.editContent setEditable:NO];
        [self.editSeg setEnabled:NO];
        // 点击保存 执行保存的方法
        [self saveClick];
    }
    
}

//点击保存按钮的点击事件
-(void)saveClick{
    // 保存标签
    self.note.tagsText = self.editTags.text;
    // 保存文本
    self.note.contentText = self.editContent.text;
    // 保存私有还是公有属性
    if(self.editSeg.selectedSegmentIndex == 0) {
        self.note.priOrPubSeg = @"私";
    } else {
        self.note.priOrPubSeg = @"公";
    }
    
    Note *noteModel = [[Note alloc] init];
//    noteModel.tagsText = self.editTags.text;
//    noteModel.contentText = self.editContent.text;
    
    // 判断代理方法是不是能够响应
    if([self.delegate respondsToSelector:@selector(editViewController:withNote:)]){
                
        //如果可以响应那么执行代理方法
        [self.delegate editViewController:self withNote:noteModel];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
