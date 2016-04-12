//
//  TopicPictureView.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/30.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define MAXW [UIScreen mainScreen].bounds.size.width - 40

#import "TopicPictureView.h"
#import "PublicModel.h"
#import <UIImageView+WebCache.h>
#import "ShowPicVC.h"
#import "ProgressView.h"

@interface TopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@end

@implementation TopicPictureView

+(instancetype)PictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
}
//  图片的自动伸缩属性 
-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imgView.userInteractionEnabled = YES;
    
    [self.imgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)]];
}

-(void)click
{
    ShowPicVC * vc = [[ShowPicVC alloc] init];
    vc.model = self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

-(void)setModel:(PublicModel *)model
{
    _model = model;
//    是否现实gif标识
    NSString * extention = model.large_pic.pathExtension;
    self.gifView.hidden = ![extention.lowercaseString isEqualToString:@"gif"];
//    显示图片
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:model.pictureProgress animated:NO];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.large_pic] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        // 计算进度值
        model.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:model.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
//        开启图形上下文
        UIGraphicsBeginImageContextWithOptions(model.pictureFrame.size, YES, 0.0);
//        开始绘画图片
        CGFloat width = model.pictureFrame.size.width;
        CGFloat heifht = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, heifht)];
//        从当前的图片中拿到图片上下文
        self.imgView.image = UIGraphicsGetImageFromCurrentImageContext();
//        结束图片上下文
        UIGraphicsEndImageContext();
    }];
//    显示点击查看图片按钮
    if (model.isTooBig) self.clickBtn.hidden = NO;
    else self.clickBtn.hidden = YES;
}

@end
