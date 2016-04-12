//
//  TopicVoiceView.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/4/6.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TopicVoiceView.h"
#import "PublicModel.h"
#import <UIImageView+WebCache.h>

@interface TopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIButton *palyBtn;
@property (weak, nonatomic) IBOutlet UILabel *vioceLentgh;
@property (weak, nonatomic) IBOutlet UILabel *muchPeople;

@end

@implementation TopicVoiceView

+(instancetype)VoiceView
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
    NSInteger minutes = model.voicetime / 60 ;
    NSInteger seconds = model.voicetime % 60 ;
    self.vioceLentgh.text = [NSString stringWithFormat:@"%02zd:%02zd",minutes,seconds];
    self.muchPeople.text = [NSString stringWithFormat:@"%zd次播放",model.playcount];
}

@end
