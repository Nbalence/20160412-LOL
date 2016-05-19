//
//  QYHeroCell.m
//  02-1601LOL
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYHeroCell.h"
#import "QYHero.h"
@implementation QYHeroCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)setHero:(QYHero *)hero {
    _hero = hero;
    
    self.textLabel.text = hero.name;
    self.detailTextLabel.text = hero.intro;
    self.imageView.image = [UIImage imageNamed:hero.icon];
    //根据vip状态设置textLabel的颜色
    self.textLabel.textColor = hero.vip ? [UIColor redColor] : [UIColor blackColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
