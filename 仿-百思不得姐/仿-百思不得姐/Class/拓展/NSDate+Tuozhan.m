//
//  NSDate+Tuozhan.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/30.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "NSDate+Tuozhan.h"

@implementation NSDate (Tuozhan)
-(NSDateComponents *)deltaFrom:(NSDate *)from
{
//    日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
//    比较的内容
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    比较的返回值
    return [calendar components:unit fromDate:from toDate:self options:0];
}

-(BOOL)isthisYear
{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger nowdate = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfdate = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowdate == selfdate;
}

-(BOOL)isYeateday
{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
//    统一转化成一种date格式
    NSDate * nowdate = [format dateFromString:[format stringFromDate:[NSDate date]]];
    NSDate * selfdate = [format dateFromString:[format stringFromDate:self]];
//    用日历比较年月日
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * delta = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfdate toDate:nowdate options:0];
//    
    return delta.year == 0 && delta.month == 0 && delta.day == 1;
}

-(BOOL)istoDay
{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString * nowdate = [format stringFromDate:[NSDate date]];
    NSString * selfdate = [format stringFromDate:self];
    
    return [nowdate isEqualToString:selfdate];
}

@end
