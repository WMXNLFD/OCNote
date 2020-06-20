//
//  ListViewController.m
//  NoteTest1
//
//  Created by ios_ljp on 2020/6/8.
//  Copyright © 2020 ios_dev. All rights reserved.
//

#import "ListViewController.h"
#import "AddViewController.h"
#import "EditViewController.h"
#include "NoteCell.h"
#include "Note.h"

// 本地存储路径
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"notes.data"]

@interface ListViewController () <AddViewControllerDelegate, EditViewControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *notes;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *resultNotes;
//@property (strong, nonatomic) NoteCell *cell;

// 内容过滤方法
- (void) filterContentForSearchText:(NSString*)searchText;

@end

@implementation ListViewController

#pragma mark 懒加载数据
- (NSMutableArray *)notes {
    if(!_notes){
        //初始化一个数组
        _notes = [NSMutableArray array];
    }
    return _notes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加左上角 退出登录按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)]; //文字 细
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStyleDone target:self action:nil]; //文字 粗
    
    self.navigationItem.leftBarButtonItem = item;
    
    // 输出 从登录界面 传过来的 username
    NSLog(@"ListViewController %@", self.username);
    
    // 取消分割线
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // 获取 doc 路径
//    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    // 解档联系人信息
    self.notes = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    
    NSLog(@"ListViewController %@", [self.notes valueForKey:@"tagsText"]);
        
    //查询所有数据
    [self filterContentForSearchText:@""];
    
    //实例化UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //设置self为更新搜索结果对象
    self.searchController.searchResultsUpdater = self;
    //设置代理
    self.searchController.searchBar.delegate = self;
    // 在搜索时，设置背景为灰色
    if (@available(iOS 9.1, *)) {
        self.searchController.obscuresBackgroundDuringPresentation = FALSE;
    } else {
        // Fallback on earlier versions
    }
    
    //将搜索栏放到表视图的表头中
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [self.searchController.searchBar sizeToFit];
    // Present 时隐藏导航栏 该属性默认也为YES
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    // 父控制器 指定
    self.definesPresentationContext = YES;
              
}

#pragma mark --内容过滤方法
- (void)filterContentForSearchText:(NSString *)searchText {
    if([searchText length] == 0) {
        // 查询所有
        self.resultNotes = [NSMutableArray arrayWithArray:self.notes];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray;
    
    scopePredicate = [NSPredicate predicateWithFormat:@"tagsText contains[c] %@", searchText];
    NSLog(@"self.notes = %@", self.notes[0]);
//    tempArray = [[self.notes valueForKey:@"tagsText"] filteredArrayUsingPredicate:scopePredicate];
    tempArray = [self.notes filteredArrayUsingPredicate:scopePredicate];
    NSLog(@"tempArray = %@", tempArray);
    self.resultNotes = [NSMutableArray arrayWithArray:tempArray];
    NSLog(@"self.resultNotes = %@", self.resultNotes);
}

#pragma mark --实现UISearchBarDelegate协议方法
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark --实现UISearchResultsUpdating协议方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    // 查询
    [self filterContentForSearchText:searchString];
    [self.tableView reloadData];
    
}


// 某一组有多少行
#pragma mark --UITableViewDataSource 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.resultNotes count];
}

// cell 的 样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"note_cell";
    
    //去缓存池找
//    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    cell.notes = self.resultNotes[indexPath.row];
    
    return cell;
}

// 让 tableView 进入编辑模式
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 把数组中的元素删掉
    [self.notes removeObject:self.notes[indexPath.row]];
    [self.resultNotes removeObjectAtIndex:indexPath.row];
    
    // 刷新
//    [self.tableView reloadData];
    
    // 删除某一行 下面的方法也会自动调用 reloadData 方法
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    // 删除数据后 归档笔记信息  传过去 笔记数组
    [NSKeyedArchiver archiveRootObject:self.notes toFile: kFilePath];
    
}



// 添加笔记 的代理方法（逆传）
-(void)addViewController:(AddViewController *)addViewController withNote:(Note *)note{
    NSLog(@"%@--%@", note.tagsText, note.contentText);
    
    //把模型数据放到 notes 的数组当中
    [self.notes addObject:note];
    [self.resultNotes addObject:note];
    
    //刷新 tableView
    [self.tableView reloadData];
    
    // 输出路径
    NSLog(@"%@", NSHomeDirectory());
            
    // 归档笔记信息  传过去 笔记数组
    [NSKeyedArchiver archiveRootObject:self.notes toFile: kFilePath];
    
}

// 编辑笔记 的代理方法
-(void)editViewController:(EditViewController *)editViewController withNote:(Note *)note{
    // 替换
    //刷新 tableView
    [self.tableView reloadData];
    // 在编辑后 归档数组（联系人信息）
    [NSKeyedArchiver archiveRootObject:self.notes toFile:kFilePath];
}

// 自要走 sb 不管是自动还是手动型 都会调用
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UIViewController *vc = segue.destinationViewController;
    if([vc isKindOfClass:[AddViewController class]])
    {
        // 设置代理
        AddViewController *add = (AddViewController *)vc;
        add.deldgate = self;
    }else{
        // 顺传 赋值
        EditViewController *edit = (EditViewController *)vc;
        
        // 设置代理
        edit.delegate = self;
        
        //获取点击cell 的位置 （indexpath）
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        // 获取模型
//        Note *noteModel = self.notes[path.row];
        Note *noteModel = self.resultNotes[path.row];
        
        //赋值
        edit.note = noteModel;
    }
}


// 退出登录 按钮的点击事件
-(void)logOut{
//    UIAlertControllerStyleActionSheet *sheet = [[UIAlertControllerStyleActionSheet alloc] ];
    
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"123" delegate:nil cancelButtonTitle:@"cancelButtonTitle" destructiveButtonTitle:@"destructiveButtonTitle" otherButtonTitles:@"11", @"22", nil];
//    [sheet showInView:self.view];
    
    //下面是警告框的消息提示 看了下微信的退出 应该使用操作表 从下面弹出消息退出
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"dad" message:@"确定要退出吗" preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"No Button");
//    }];
//
//    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"yes Button");
//    }];
//
//    [alertController addAction:noAction];
//    [alertController addAction:yesAction];
//
//    [self presentViewController:alertController animated:YES completion:nil];
    
    // 下面是操作表 弹出消息退出
    UIAlertController *actionSheetController = [[UIAlertController alloc] init];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消 Button");
    }];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"退出登录 Button");
        // 返回上一个控制器
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:yesAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
    
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
