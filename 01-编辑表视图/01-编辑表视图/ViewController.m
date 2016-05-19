//
//  ViewController.m
//  01-编辑表视图
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *dict;           //所有的section中的数据集合
@property (nonatomic, strong) NSArray *keys;                //section头标题组成的数组

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController
static NSString *identifier = @"cell";
//加载数据
- (void) loadDatasFormFile {
    //1、获取plist文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    //2、从plist文件加载数据
    _dict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    //3、取出所有的键，并排序
    _keys = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

//懒加载tableView
- (UITableView *) tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //注册单元格
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadDatasFormFile];
    
    //添加tableView
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.target = self;
    self.editButtonItem.action = @selector(changeTableViewEdit:);
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)changeTableViewEdit:(UIBarButtonItem *)barBtnItem {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    barBtnItem.title = self.tableView.editing ? @"Done" : @"Edit";
}

#pragma mark  -UITableViewDataSource
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _keys.count;
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //1、取出当前section对应的键
    NSString *key = _keys[section];
    //2、从字典中取出当前section对应的数组
    NSArray *array = _dict[key];
    //3、返回取到的数组的长度
    return array.count;
}
//行内容
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //1、取出当前section对应的键
    NSString *key = _keys[indexPath.section];
    //2、从字典中取出当前section对应的数组
    NSArray *array = _dict[key];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}
//section的头标题
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _keys[section];
}
//设置索引
- (NSArray <NSString *> *) sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _keys;
}

#pragma mark  -编辑（删除或添加）
//允许编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//指定编辑样式
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row % 2 ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
}
//提交编辑
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //1、取出当前的编辑行对应的sction的数组（可变）
    
    NSString *key = _keys[indexPath.section];
    NSMutableArray *array = _dict[key];
    
    //2、判断当前的编辑样式
        //如果是删除，删除数组中对应的数据，并且删除当前行（界面）
        //如果是插入，往数组中插入对应的数据，并且插入新行（界面）
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除数据
        [array removeObjectAtIndex:indexPath.row];
        //界面删除行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        //插入数据
        [array insertObject:@"青云1601最棒！！！" atIndex:indexPath.row];
        //界面插入行
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

#pragma mark  -编辑（移动）

//允许移动
- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//移动单元格
- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    //1、取出source section对应的键
    NSString  *sourceKey = _keys[sourceIndexPath.section];
    //2、取出源单元格所在的section的数据(可变数组)
    NSMutableArray *sourceArray = _dict[sourceKey];
    //3、取出当前移动单元格的数据
    NSString *sourceString = sourceArray[sourceIndexPath.row];
    //4、把当前单元格的数据从源数据源中删除
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    
    //5、取出destination section对应得键
    NSString *destinationKey = _keys[destinationIndexPath.section];
    //6、找到目的的section的数据（可变数组）
    NSMutableArray *destinationArray = _dict[destinationKey];
    //7、把取出的单元格的数据插入目的section对应的数组
    [destinationArray insertObject:sourceString atIndex:destinationIndexPath.row];
}

//rowAction
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建rowAction
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //1、取出当前的编辑行对应的sction的数组（可变）
        NSString *key = _keys[indexPath.section];
        NSMutableArray *array = _dict[key];
        //删除数据
        [array removeObjectAtIndex:indexPath.row];
        //界面删除行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }];
    
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"分享" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    return @[action1,action2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


//取出单元格
QYFriendsModal *haroModal = self.friendsModal[sourceIndexPath.section];

NSMutableArray *mArr = haroModal.friends[sourceIndexPath.row];

[haroModal.friends removeObjectAtIndex:sourceIndexPath.row];

QYFriendsModal *deHaroModal = self.friendsModal[destinationIndexPath.section];

[deHaroModal.friends insertObject:mArr atIndex:destinationIndexPath.row];





