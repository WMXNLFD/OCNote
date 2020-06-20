//
//  InsetLabel.m
//  demo
//
//  Created by ios_ljp on 2020/6/18.
//  Copyright © 2020 maimemo. All rights reserved.
//

#import "InsetLabel.h"

@implementation InsetLabel

- (void)setLaleInset:(UIEdgeInsets)inset {
    self.insets = inset;
}

- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets{
    self = [super initWithFrame:frame];
    if(self) {
        self.insets = insets;
    }
    return self;
}

- (id)initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self) {
        self.insets = insets;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    return [super drawRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
