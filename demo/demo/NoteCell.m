//
//  NoteCell.m
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/13.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import "NoteCell.h"
#import "Note.h"
#import "InsetLabel.h"

@interface NoteCell()

// 目前定义三个标签
@property (weak, nonatomic) IBOutlet InsetLabel *tagView1;
@property (weak, nonatomic) IBOutlet UILabel *tagView2;
@property (weak, nonatomic) IBOutlet UILabel *tagView3;
@property (weak, nonatomic) IBOutlet UIButton *tagView4;
// 属于自己的笔记
@property (weak, nonatomic) IBOutlet UILabel *meView;
// 私有属性
@property (weak, nonatomic) IBOutlet UILabel *priView;
// 文本内容
@property (weak, nonatomic) IBOutlet UILabel *textView;
// 公有属性
@property (weak, nonatomic) IBOutlet UILabel *pubView;

@end

@implementation NoteCell

// 给notes 属性赋值
- (void)setNotes:(Note *)notes{
    _notes = notes;
    
    // 设置标签的内边距
//    [self.tagView1 setLaleInset:UIEdgeInsetsMake(5, 2, 5, 2)];
//    [self.tagView1 sizeToFit];
    
    //获取私有还是公有属性
    NSString *priOrPub = notes.priOrPubSeg;
    NSLog(@"NoteCell %@", priOrPub);
    // 判断显示私有标签还是公有标签
    if([priOrPub isEqualToString:@"公"]) {
        self.priView.hidden = YES;
        self.pubView.hidden = NO;
    } else {
        self.priView.hidden = NO;
        self.pubView.hidden = YES;
    }
    
    // 获取文本框内容
    self.textView.text = notes.contentText;
    // 分割标签 
    NSString *tagsText = notes.tagsText;
    NSArray *tagArray = [tagsText componentsSeparatedByString:@"/"];
    
//    for(NSString *tag in tagArray){
//        NSLog(@"%@", tag);
//    }
    
//    self.tagView1.text = tagArray[0];
//    if(tagArray.count > 1) self.tagView2.text = tagArray[1];
//    if(tagArray.count > 2) self.tagView3.text = tagArray[2];
    
    // 标签赋值和隐藏
    switch (tagArray.count) {
        case 4:
            self.tagView1.text = tagArray[0];
            self.tagView2.text = tagArray[1];
            self.tagView3.text = tagArray[2];
            [self.tagView4 setTitle:tagArray[3] forState:UIControlStateNormal];
            self.tagView4.hidden = NO;
            self.tagView2.hidden = NO;
            self.tagView3.hidden = NO;
            break;
        case 3:
            self.tagView1.text = tagArray[0];
            self.tagView2.text = tagArray[1];
            self.tagView3.text = tagArray[2];
            self.tagView2.hidden = NO;
            self.tagView3.hidden = NO;
            self.tagView4.hidden = YES;
            break;
        case 2:
            self.tagView1.text = tagArray[0];
            self.tagView2.text = tagArray[1];
            self.tagView2.hidden = NO;
            self.tagView3.hidden = YES;
            self.tagView4.hidden = YES;
            break;
        case 1:
            self.tagView1.text = tagArray[0];
            self.tagView2.hidden = YES;
            self.tagView3.hidden = YES;
            self.tagView4.hidden = YES;
            break;
        default:
            break;
    }
    
}

@end
