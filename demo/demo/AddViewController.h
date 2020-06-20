//
//  AddViewController.h
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/9.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

NS_ASSUME_NONNULL_BEGIN
@class AddViewController;

@protocol AddViewControllerDelegate <NSObject>

@optional
-(void)addViewController:(AddViewController*)addViewController withNote:(Note *)note;

@end

@interface AddViewController : UIViewController

@property (nonatomic, weak) id<AddViewControllerDelegate> deldgate;

@end

NS_ASSUME_NONNULL_END
