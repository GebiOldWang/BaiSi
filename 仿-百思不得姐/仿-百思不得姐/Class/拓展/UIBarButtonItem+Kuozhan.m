//
//  UIBarButtonItem+Kuozhan.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/16.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "UIBarButtonItem+Kuozhan.h"

@implementation UIBarButtonItem (Kuozhan)

+(instancetype)itemWithImage:(NSString *)image HightLightImage:(NSString *)himage target:(id)target action:(SEL)action
{
    UIButton * Btn = [UIButton buttonWithType:0];
    [Btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:himage] forState:UIControlStateHighlighted];
    
    Btn.size = Btn.currentBackgroundImage.size;
    
    [Btn addTarget:target action:(action) forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:Btn];

}

@end
