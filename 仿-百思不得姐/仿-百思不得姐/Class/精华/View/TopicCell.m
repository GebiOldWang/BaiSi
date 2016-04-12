//
//  TopicCell.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/29.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define MAXW  [UIScreen mainScreen].bounds.size.width - 40

#import "TopicCell.h"
#import "PublicModel.h"
#import <UIImageView+WebCache.h>
#import "TopicPictureView.h"
#import "TopicVoiceView.h"
#import "TopicVideoView.h"
#import "CommentModel.h"
#import "UserModel.h"

@interface TopicCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */


@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vView;

@property (weak, nonatomic) IBOutlet UILabel *contentText;
//  图片的xib
@property (nonatomic , weak) TopicPictureView * pictureView;
//  声音的xib
@property (nonatomic, weak) TopicVoiceView * voiceView;
//  视频的xib
@property (nonatomic, weak) TopicVideoView * videoView;
@property (weak, nonatomic) IBOutlet UIView *commontView;
@property (weak, nonatomic) IBOutlet UILabel *commondLabel;

@end

@implementation TopicCell

+(instancetype)createCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(TopicPictureView *)pictureView
{
    if (!_pictureView) {
        TopicPictureView * pictureView = [TopicPictureView PictureView];
        [self addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

-(TopicVoiceView *)voiceView
{
    if (!_voiceView) {
        TopicVoiceView * voiceView = [TopicVoiceView VoiceView];
        [self addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

-(TopicVideoView *)videoView
{
    if (!_videoView) {
        TopicVideoView * videoView = [TopicVideoView VideoView];
        [self addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

-(void)setModel:(PublicModel *)model
{
    _model = model;
    // 设置其他控件
    self.profileImageView.layer.cornerRadius = 17;
    self.profileImageView.layer.masksToBounds = YES;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = model.name;
    
    self.createTimeLabel.text = model.create_time;
    
    self.sina_vView.hidden = !model.isSina_v;
    
    self.contentText.text = model.text;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:model.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:model.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:model.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:model.comment placeholder:@"评论"];
    
    if (model.type == TopicTypePicture) {//   是图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.model = model;
        self.pictureView.frame = model.pictureFrame;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (model.type == TopicTypeVoice){//  声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.model = model;
        self.voiceView.frame = model.voiceFrame;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if(model.type == TopicTypeVideo){//   视频帖子
        self.videoView.hidden = NO;
        self.videoView.model = model;
        self.videoView.frame = model.videoFrame;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    }else{//    段子帖子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
//    评论内容
    CommentModel * comment = [model.top_cmt firstObject];
    if (comment) {
        self.commontView.hidden = NO;
        self.commondLabel.text = [NSString stringWithFormat:@"%@ : %@",comment.user.username,comment.content];
    }else{
        self.commontView.hidden = YES;
    }
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}
//  重写cell 的frame  上左右留有间隙
- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width = ViewW - 2 * margin;
    frame.size.height = self.model.cellHeight - margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}
- (IBAction)more
{
    [[[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil] showInView:self.window];
}

@end
