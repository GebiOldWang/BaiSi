//
//  LeftModel.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/17.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "LeftModel.h"

@implementation LeftModel

-(NSMutableArray *)arrays{
    if (!_arrays) {
        _arrays = [NSMutableArray array];
    }
    return _arrays;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

+(NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"ID"]) return @"id";
    
    return propertyName;
}

@end
