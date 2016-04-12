//
//  TabBar.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/16.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TabBar.h"
#import "FaTieView.h"

@interface TabBar()

@property (nonatomic, weak) UIButton * btn;

@end

@implementation TabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setBackgroundImage:[UIImage imageNamed:@"tabBar-light"]];
        
        UIButton * newBtn = [UIButton buttonWithType:0];
        [newBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [newBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        newBtn.size = newBtn.currentBackgroundImage.size;
        [newBtn addTarget:self action:@selector(faTie) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:newBtn];
        self.btn = newBtn;
    }
    return self;
}

//  布局子控件   专门用来重新布局的
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;

    self.btn.center = CGPointMake(width * 0.5, height * 0.5);
    
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    
    NSInteger index = 0;
    
    for (UIView * button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.btn)
            continue;
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index ++;
    }
}

-(void)faTie
{
    [FaTieView show];
}

@end
