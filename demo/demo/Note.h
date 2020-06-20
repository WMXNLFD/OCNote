//
//  Note.h
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/9.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject <NSCoding>

@property (nonatomic, copy) NSString *tagsText;
@property (nonatomic, copy) NSString *contentText;
@property (nonatomic, copy) NSString *priOrPubSeg;

@end

NS_ASSUME_NONNULL_END
