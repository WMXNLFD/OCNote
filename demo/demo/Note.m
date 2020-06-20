//
//  Note.m
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/9.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import "Note.h"

@implementation Note

// 告诉系统归档哪些属性
-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_tagsText forKey:@"tags"];
    [coder encodeObject:_contentText forKey:@"content"];
    [coder encodeObject:_priOrPubSeg forKey:@"priorpub"];
}

// 告诉系统解档哪些属性
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _tagsText = [coder decodeObjectForKey:@"tags"];
        _contentText = [coder decodeObjectForKey:@"content"];
        _priOrPubSeg = [coder decodeObjectForKey:@"priorpub"];
    }
    return self;
}

@end
