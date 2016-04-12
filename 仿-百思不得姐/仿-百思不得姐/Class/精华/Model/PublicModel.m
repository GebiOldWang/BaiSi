//
//  PublicModel.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/30.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define MAXW [UIScreen mainScreen].bounds.size.width - 40
#define MAXH [UIScreen mainScreen].bounds.size.height * 0.8

#import "PublicModel.h"
#import "CommentModel.h"
#import "UserModel.h"

@interface PublicModel()
{
    CGFloat _cellHeight;
}

@end

@implementation PublicModel
//  一边留10px
static CGFloat const margin = 20;
//  底部留8px
static CGFloat const lowHeight = 8;
//  开始的x
static CGFloat const beginX = 10;
//  带图 图文以上的距离
static CGFloat const addY = 66;

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"small_pic":@"image0",
             @"large_pic":@"image1",
             @"middle_pic":@"image0",
             @"ID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt":@"CommentModel"};
}

-(NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isthisYear) { // 今年
        if (create.istoDay) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYeateday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

-(CGFloat)cellHeight
{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(MAXW, MAXFLOAT);
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        // cell的高度
        _cellHeight = textH + 115;
//        公众参数
        CGFloat publicX = beginX;
        CGFloat publicY = textH + addY;
        CGFloat publicW = MAXW;
        // 显示显示出来的高度
        CGFloat publicH = (publicW - margin) * self.height / self.width;
        CGRect Frame = CGRectMake(publicX, publicY, publicW, publicH);
        if (self.type == TopicTypePicture) {// 图片
//            超出
            if (publicH >= MAXH) {
                self.isBig = YES;
                publicH = MAXW;
                Frame = CGRectMake(publicX, publicY, publicW, publicH);
            }
            // 计算图片控件的frame
            _pictureFrame= Frame;
            _cellHeight += publicH + lowHeight;
        }else if (self.type == TopicTypeVoice){// 音频
            _voiceFrame = Frame;
            _cellHeight += publicH + lowHeight;
        }else if (self.type == TopicTypeVideo){// 视频
            _videoFrame = Frame;
            _cellHeight += publicH + lowHeight;
        }
        
        CommentModel * cmt = [self.top_cmt firstObject];
        if (cmt) {
            NSString * string = [NSString stringWithFormat:@"%@ : %@",cmt.user.username,cmt.content];
            CGFloat cmtH = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += 25 +cmtH ;
        }
    }
    return _cellHeight;
}

@end

