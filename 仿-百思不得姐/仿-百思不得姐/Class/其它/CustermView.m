//
//  CustermView.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/22.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "CustermView.h"
#import "PublicModel.h"

@implementation CustermView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)remove:(UIButton *)sender {
    [self removeFromSuperview];
}

@end
