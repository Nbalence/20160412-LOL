//
//  QYHero.m
//  02-1601LOL
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYHero.h"

@implementation QYHero
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)heroWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
@end
