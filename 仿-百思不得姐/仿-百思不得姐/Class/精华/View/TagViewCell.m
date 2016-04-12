//
//  TagViewCell.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/21.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TagViewCell.h"
#import "TagModel.h"
#import "UIImageView+WebCache.h"

@interface TagViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *Timage;

@property (weak, nonatomic) IBOutlet UILabel *Tname;

@property (weak, nonatomic) IBOutlet UILabel *Tnumber;

@end

@implementation TagViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(TagModel *)model
{
    _model = model;
    [self.Timage sd_setImageWithURL:[NSURL URLWithString:model.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.Tname.text = model.theme_name;
    if (model.sub_number > 10000) {
        self.Tnumber.text = [NSString stringWithFormat:@"%.1f万人订阅",model.sub_number/10000.0];
    }else{
        self.Tnumber.text = [NSString stringWithFormat:@"%zd订阅",model.sub_number];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//   重写frame方法 来实现cell形状的改变
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= 2* frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
