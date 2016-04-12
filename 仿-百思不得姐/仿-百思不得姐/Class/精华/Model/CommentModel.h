//
//  CommentModel.h
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/4/6.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;

@interface CommentModel : NSObject

@property (nonatomic , assign) NSString * ID;

@property (nonatomic , assign) NSInteger voicetime;

@property (nonatomic , assign) NSString * voiceuri;

@property (nonatomic , assign) NSInteger like_count;

@property (nonatomic , copy) NSString * content;

@property (nonatomic , strong) UserModel * user;


@end
