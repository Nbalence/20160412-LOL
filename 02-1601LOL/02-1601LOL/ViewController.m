//
//  ViewController.m
//  02-1601LOL
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYHeroGroup.h"
#import "QYHero.h"
#import "QYHeroCell.h"
#import "QYHeroSctionHeaderView.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *heroGroups;                  //section集合

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController
static NSString *identifier = @"hero";
//懒加载数据
- (NSArray *)heroGroups {
    if (_heroGroups == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hero" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYHeroGroup *heroGroup = [QYHeroGroup heroGroupWithDictionary:dict];
            [models addObject:heroGroup];
        }
        _heroGroups = models;
    }
    return _heroGroups;
}
//懒加载tableView
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //注册单元格
        [_tableView registerClass:[QYHeroCell class] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加tableView
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -UITableViewDataSource
//组数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.heroGroups.count;
}

//组内行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    QYHeroGroup *heroGroup = self.heroGroups[section];
    if (heroGroup.isOpen) {
       return heroGroup.friends.count;
    }else{
        return 0;
    }
}

//行内容
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#if 0
    QYHeroCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QYHeroCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
#else
    QYHeroCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
#endif
    //1、取出当前row所在的section对应的模型
    QYHeroGroup *heroGroup = self.heroGroups[indexPath.section];
    //2、取出当前row对应的模型
    QYHero *hero = heroGroup.friends[indexPath.row];
    
    cell.hero = hero;
    
    return cell;
}
#if 0
//设置section的头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    QYHeroGroup *heroGroup = self.heroGroups[section];
    return heroGroup.name;
}
#endif

//设置section头视图高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

//设置section的头视图
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QYHeroSctionHeaderView *headerView = [QYHeroSctionHeaderView sectionHeaderView:tableView];
    //设置heroGroup属性
    QYHeroGroup *heroGroup = self.heroGroups[section];
    headerView.heroGroup = heroGroup;
    
    headerView.headerViewClick = ^{
        //刷新表视图
        [tableView reloadData];
    };
    
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
