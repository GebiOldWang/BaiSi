//
//  CommentCell.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/4/7.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "CommentCell.h"
#import <UIImageView+WebCache.h>
#import "CommentModel.h"
#import "UserModel.h"

@interface CommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation CommentCell

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setModel:(CommentModel *)model
{
    _model = model;
    self.profileImageView.layer.cornerRadius = 18;
    self.profileImageView.layer.masksToBounds = YES;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:model.user.profile_image]];
    self.sexView.image = [model.user.sex isEqualToString:UserSexM] ? [UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"] ;
    self.contentLabel.text = model.content;
    if (model.voicetime == 0) {
        self.voiceButton.hidden = YES;
    }else{
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",model.voicetime] forState:UIControlStateNormal];
    }
    self.usernameLabel.text = model.user.username;
    if (model.like_count) {
        self.likeCountLabel.text = [NSString stringWithFormat:@"+%zd",model.like_count];
    }else{
        self.likeCountLabel.hidden = YES;
    }

}

@end
