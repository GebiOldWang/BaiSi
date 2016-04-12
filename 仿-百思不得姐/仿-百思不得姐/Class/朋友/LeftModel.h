//
//  LeftModel.h
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/17.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeftModel : NSObject

/** id */
@property (nonatomic, assign) NSInteger ID;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray * arrays;

@property (nonatomic , assign) NSInteger total;

@property (nonatomic , assign) NSInteger current_page;

@end
