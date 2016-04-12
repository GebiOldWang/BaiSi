//
//  MineViewController.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/16.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem * item1 = [UIBarButtonItem itemWithImage:@"mine-setting-icon" HightLightImage:@"mine-setting-icon-click" target:self action:@selector(setBtnClick)];
    UIBarButtonItem * item2 = [UIBarButtonItem itemWithImage:@"mine-moon-icon" HightLightImage:@"mine-moon-icon-click" target:self action:@selector(moonBtnClick)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
    self.view.backgroundColor = DefaultColor;
}

-(void)setBtnClick
{
    PFUNC;
}

-(void)moonBtnClick
{
    PFUNC;
}

@end
