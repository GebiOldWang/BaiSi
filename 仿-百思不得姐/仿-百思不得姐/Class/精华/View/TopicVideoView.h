//
//  TopicVideoView.h
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/4/6.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PublicModel;

@interface TopicVideoView : UIView

@property (nonatomic, weak) PublicModel * model;

+(instancetype)VideoView;

@end
