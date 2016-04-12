//
//  TopicVideoView.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/4/6.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TopicVideoView.h"
#import "PublicModel.h"
#import <UIImageView+WebCache.h>

@interface TopicVideoView ()
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;

@end

@implementation TopicVideoView

+(instancetype)VideoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] lastObject];
}

-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setModel:(PublicModel *)model
{
    _model = model;
    [self.backImage sd_setImageWithURL:[NSURL URLWithString:model.large_pic]];
    NSInteger minutes = model.videotime / 60 ;
    NSInteger seconds = model.videotime % 60 ;
    self.lengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minutes,seconds];
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd次播放",model.playcount];
}

@end
