//
//  PublicModel.h
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/30.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicModel : NSObject
//id
@property (nonatomic , copy) NSString * ID;
//姓名
@property (nonatomic , copy) NSString * name;
//头像
@property (nonatomic , copy) NSString * profile_image;
//内容
@property (nonatomic , copy) NSString * text;
//发帖时间
@property (nonatomic , copy) NSString * create_time;
//顶帖
@property (nonatomic , assign) NSInteger ding;
//踩
@property (nonatomic , assign) NSInteger cai;
//转发
@property (nonatomic , assign) NSInteger repost;
//评论
@property (nonatomic , assign) NSInteger comment;
//新浪加v用户
@property (nonatomic , assign ,getter=isSina_v) BOOL sina_v;
//图片宽度
@property (nonatomic , assign) CGFloat width;
//图片高度
@property (nonatomic , assign) CGFloat height;
@property (nonatomic , copy) NSString * small_pic;
@property (nonatomic , copy) NSString * large_pic;
@property (nonatomic , copy) NSString * middle_pic;

//  进度条的进度
@property (nonatomic , assign) CGFloat  pictureProgress;
//声音长度
@property (nonatomic , assign) NSInteger voicetime;
//音频播放的url地址
@property (nonatomic , assign) NSString * voiceuri;
//播放次数
@property (nonatomic , assign) NSInteger playcount;
//视频时长
@property (nonatomic , assign) NSInteger videotime;
//视频播放的url地址
@property (nonatomic , copy) NSString * videouri;
//最热评论
@property (nonatomic, strong) NSArray * top_cmt;

/****  cell的判断属性  ****/

//帖子的类型
@property (nonatomic , assign) TopicType type;
//cell的高度
@property (nonatomic , assign ,readonly) CGFloat cellHeight;
//picture中间图片的frame
@property (nonatomic , assign ,readonly) CGRect pictureFrame;
//voice中间图片的frame
@property (nonatomic , assign ,readonly) CGRect voiceFrame;
//video中间图片的frame
@property (nonatomic , assign ,readonly) CGRect videoFrame;
//图片是否太大
@property (nonatomic , assign ,getter=isTooBig) BOOL isBig;

@end

