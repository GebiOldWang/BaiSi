//
//  RightCell.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/17.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "RightCell.h"
#import "RightModel.h"
#import "UIImageView+WebCache.h"

@interface RightCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headimg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fans;

@end

@implementation RightCell

-(void)setModel:(RightModel *)model
{
    _model = model;
    self.name.text = model.screen_name;
    if (model.fans_count > 10000) {
        self.fans.text = [NSString stringWithFormat:@"%.1f人关注",model.fans_count/10000.0];
    }else{
        self.fans.text = [NSString stringWithFormat:@"%zd人关注",model.fans_count];
    }
    [self.headimg sd_setImageWithURL:[NSURL URLWithString:model.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
