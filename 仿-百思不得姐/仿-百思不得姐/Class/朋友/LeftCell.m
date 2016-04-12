//
//  LeftCell.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/17.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "LeftCell.h"
#import "LeftModel.h"

@interface LeftCell ()

@property (weak, nonatomic) IBOutlet UIView *leftBar;

@end

@implementation LeftCell

-(void)setModel:(LeftModel *)model
{
    _model = model;
    self.textLabel.text = [NSString stringWithFormat:@"%@",model.name];
}

- (void)awakeFromNib {
    self.backgroundColor = RGBColor(244, 244, 244);
    self.leftBar.backgroundColor = RGBColor(219, 21, 26);
}
//  处理cell的选中事件
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.leftBar.hidden = !selected;
    self.textLabel.textColor = selected ? self.leftBar.backgroundColor : RGBColor(78, 78, 78);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

@end
