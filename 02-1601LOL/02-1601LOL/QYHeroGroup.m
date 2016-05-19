//
//  QYHeroGroup.m
//  02-1601LOL
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYHeroGroup.h"
#import "QYHero.h"
@implementation QYHeroGroup

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        //遍历friends，把其中的字典转化成模型QYHero
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in self.friends) {
            QYHero *hero = [QYHero heroWithDictionary:dic];
            [models addObject:hero];
        }
        self.friends = models;
    }
    return self;
}

+(instancetype)heroGroupWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
@end
