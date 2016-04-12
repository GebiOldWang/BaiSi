//
//  FaTieView.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/31.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "FaTieView.h"
#import "CustemButton.h"
#import <POP.h>

@interface FaTieView ()

@end

@implementation FaTieView

static CGFloat const AnimationDelay = 0.1;
static CGFloat const AnimationspringSpeed = 10;
static CGFloat const AnimationspringBounciness = 10;

static UIWindow * window_;

+(instancetype)FatieView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+(void)show
{
//    窗口
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    window_.hidden = NO;
//  添加页面
    FaTieView * view = [FaTieView FatieView];
    view.frame = window_.bounds;
    [window_ addSubview:view];
}

- (void)awakeFromNib{
    // Do any additional setup after loading the view from its nib
    self.userInteractionEnabled = NO;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (ViewH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (ViewW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        CustemButton *button = [[CustemButton alloc] init];
        button.tag = i ;
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置frame
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat btnX = buttonStartX + col * (xMargin + buttonW);
        CGFloat btnEndY = buttonStartY + row * buttonH;
        CGFloat btnBeginY = btnEndY - ViewH;
        [self addSubview:button];
        
//        添加pop动画
        POPSpringAnimation * animaton = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animaton.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnBeginY, buttonW, buttonH)];
        animaton.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY, buttonW, buttonH)];
//        开始时间
        animaton.beginTime = CACurrentMediaTime() + AnimationDelay * i ;
        animaton.springSpeed = AnimationspringSpeed ;//  弹簧速度
        animaton.springBounciness = AnimationspringBounciness ;//  弹簧幅度
        [button pop_addAnimation:animaton forKey:nil];
    }
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat sloCenterX = ViewW * 0.5;
    CGFloat sloCenterY = ViewH * 0.2 -ViewH;
    CGFloat sloEndCenterY = ViewH * 0.2;
    [self addSubview:sloganView];
    POPSpringAnimation * animaton = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animaton.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloCenterX, sloCenterY)];
    animaton.toValue = [NSValue valueWithCGPoint:CGPointMake(sloCenterX, sloEndCenterY)];
    //        开始时间
    animaton.beginTime = CACurrentMediaTime() + AnimationDelay * 6 ;
    animaton.springSpeed = AnimationspringSpeed ;//  弹簧速度
    animaton.springBounciness = AnimationspringBounciness ;//  弹簧幅度
    [animaton setCompletionBlock:^(POPAnimation * animatipn, BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:animaton forKey:nil];
}

-(IBAction)dissmiss
{
    [self completBlock:nil];
}

-(void)buttonClick:(UIButton *)sender
{
    [self completBlock:^{
        switch (sender.tag) {
            case 0:
                P(@"发视频");
                break;
            case 1:
                P(@"发图片");
                break;
            case 2:
                P(@"发段子");
                break;
            case 3:
                P(@"发生意");
                break;
            case 4:
                P(@"神贴");
                break;
            case 5:
                P(@"下载");
                break;
                
            default:
                break;
        }
    }];
}

-(void)completBlock:(void (^)())block
{
    self.userInteractionEnabled = YES;
    int beginIndex = 1;
    //    退出动画
    for (int i = beginIndex ; i < self.subviews.count ; i++){
        UIView * view = self.subviews[i];
        CGFloat EndY = view.centerY + ViewH ;
        POPBasicAnimation * animaton = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        //        动画函数
        animaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animaton.toValue = [NSValue valueWithCGPoint:CGPointMake(ViewW * 0.5, EndY)];
        //        开始时间
        animaton.beginTime = CACurrentMediaTime() + AnimationDelay * (i - beginIndex);
        [self.subviews[i] pop_addAnimation:animaton forKey:nil];
        if (i == self.subviews.count - 1) {
            animaton.completionBlock = ^(POPAnimation * animation, BOOL finished){
//                [self removeFromSuperview];
                window_.hidden = YES;
                window_ = nil;
                !block ? :block();
            };
        }
    }

}

@end
