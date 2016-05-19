//
//  QYHeroSctionHeaderView.m
//  02-1601LOL
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYHeroSctionHeaderView.h"
#import "QYHeroGroup.h"
@interface QYHeroSctionHeaderView ()
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UILabel *numLabel;
@end

@implementation QYHeroSctionHeaderView

static NSString *identifier = @"headerView";

+ (instancetype) sectionHeaderView:(UITableView *)tableView{
    QYHeroSctionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (headerView == nil) {
        headerView = [[QYHeroSctionHeaderView alloc] initWithReuseIdentifier:identifier];
    }
    headerView.contentView.backgroundColor = [UIColor redColor];
    return headerView;
}

- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //1、添加背景的button
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bgButton];
        
        //设置背景图片
        UIImage *image = [[UIImage imageNamed:@"buddy_header_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 1, 44, 0) resizingMode:UIImageResizingModeStretch];
        UIImage *highLightedImage = [[UIImage imageNamed:@"buddy_header_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 1, 44, 0) resizingMode:UIImageResizingModeStretch];
        [bgButton setBackgroundImage:image forState:UIControlStateNormal];
        [bgButton setBackgroundImage:highLightedImage forState:UIControlStateHighlighted];
        
        //设置标题颜色
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置图片
        [bgButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        //设置内容对齐方式
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置内容的偏移
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设施标题的偏移
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        //设置btn中图片显示的模式
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        //添加事件监听
        [bgButton addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //2、添加右边的label
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        
        //对齐方式
        label.textAlignment = NSTextAlignmentRight;
        
        
        _bgBtn = bgButton;
        _numLabel = label;
    }
    return self;
}

//设置子视图frame
- (void)layoutSubviews {
    [super layoutSubviews];
    //1、设置bgBtn的frame
    _bgBtn.frame = self.bounds;
    //2、设置numLabel的frame
    CGFloat labelW = 100;
    CGFloat labelH = CGRectGetHeight(self.bounds);
    CGFloat labelX = CGRectGetWidth(self.bounds) - labelW - 10;
    CGFloat labelY = CGRectGetHeight(self.bounds) - labelH;
    _numLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

-(void)setHeroGroup:(QYHeroGroup *)heroGroup {
    _heroGroup = heroGroup;
    //1、设置bgBtn的标题
    [_bgBtn setTitle:heroGroup.name forState:UIControlStateNormal];
    //2、设置numLabel的文本
    _numLabel.text = [NSString stringWithFormat:@"%ld/%ld",heroGroup.online,heroGroup.friends.count];
    
    //2、旋转图片（M_PI_2）
    if (_heroGroup.isOpen) {
        _bgBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        _bgBtn.imageView.transform = CGAffineTransformIdentity;
    }
    
}

- (void) bgBtnClick:(UIButton *)sender {
    //1、更改isOpen状态
    _heroGroup.isOpen = !_heroGroup.isOpen;
    
    //3、刷新界面
    if (_headerViewClick) {
        _headerViewClick();
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
