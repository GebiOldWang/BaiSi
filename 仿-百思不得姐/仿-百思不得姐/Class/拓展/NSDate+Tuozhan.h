//
//  NSDate+Tuozhan.h
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/30.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Tuozhan)
//  比较日期的差距
-(NSDateComponents *)deltaFrom:(NSDate *)from;
/*
 *  是不是今年
 */
-(BOOL)isthisYear;
/*
 *  是不是今天
 */
-(BOOL)istoDay;
/*
 *  是不是昨天
 */
-(BOOL)isYeateday;

@end
