//
//  QYHero.h
//  02-1601LOL
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYHero : NSObject
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic)         BOOL vip;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)heroWithDictionary:(NSDictionary *)dict;
@end
