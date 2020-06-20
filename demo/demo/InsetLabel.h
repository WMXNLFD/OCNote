//
//  InsetLabel.h
//  demo
//
//  Created by ios_ljp on 2020/6/18.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InsetLabel : UILabel

// insert 属性
@property (nonatomic) UIEdgeInsets insets;

- (id)initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets)insets;
- (id)initWithInsets:(UIEdgeInsets)insets;

// 设置内边距
- (void) setLaleInset:(UIEdgeInsets)inset;

@end

NS_ASSUME_NONNULL_END
