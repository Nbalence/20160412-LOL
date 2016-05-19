//
//  QYHeroGroup.h
//  02-1601LOL
//
//  Created by qingyun on 16/4/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYHeroGroup : NSObject
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, strong) NSString *name;
@property (nonatomic)         NSInteger online;
@property (nonatomic)         BOOL isOpen;              //标识当前section是否打开（yes:打开，no:关闭）

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)heroGroupWithDictionary:(NSDictionary *)dict;
@end
