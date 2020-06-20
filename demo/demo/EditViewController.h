//
//  EditViewController.h
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/9.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@class EditViewController;

@protocol EditViewControllerDelegate <NSObject>

@optional
-(void)editViewController:(EditViewController *)editViewController withNote:(Note *)note;

@end

@interface EditViewController : UIViewController

@property (nonatomic, strong) Note* note;
@property(nonatomic, weak) id<EditViewControllerDelegate> delegate; 

@end

NS_ASSUME_NONNULL_END
