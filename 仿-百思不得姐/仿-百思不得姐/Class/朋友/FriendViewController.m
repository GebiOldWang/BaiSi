//
//  FriendViewController.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/16.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "FriendViewController.h"
#import "RecommendedVC.h"
#import "LoginAndRegisterVC.h"

@interface FriendViewController ()

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的关注";

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" HightLightImage:@"friendsRecommentIcon-click" target:self action:@selector(leftBtnClick)];
    
    self.view.backgroundColor = DefaultColor;
}

-(void)leftBtnClick
{
    PFUNC;
    RecommendedVC * VC = [[RecommendedVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
- (IBAction)LoginRegister {
    LoginAndRegisterVC * loginVC = [[LoginAndRegisterVC alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


@end
