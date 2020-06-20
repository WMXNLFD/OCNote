//
//  NoteCell.h
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/13.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Note;
@interface NoteCell : UITableViewCell

@property (nonatomic, strong) Note *notes;

@end

NS_ASSUME_NONNULL_END
