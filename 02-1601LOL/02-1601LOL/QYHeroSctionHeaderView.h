//
//  QYHeroSctionHeaderView.h
//  02-1601LOL
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYHeroGroup;
@interface QYHeroSctionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) void (^headerViewClick)();

@property (nonatomic, strong) QYHeroGroup *heroGroup;

+ (instancetype) sectionHeaderView:(UITableView *)tableView;

@end
