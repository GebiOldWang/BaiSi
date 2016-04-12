//
//  NewViewController.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/16.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    self.navigationItem.leftBarButtonItem = self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" HightLightImage:@"MainTagSubIconClick" target:self action:@selector(leftBtnClick)];
    
    self.view.backgroundColor = DefaultColor;
}

-(void)leftBtnClick
{
    P(@"%s",__func__);
}


@end
