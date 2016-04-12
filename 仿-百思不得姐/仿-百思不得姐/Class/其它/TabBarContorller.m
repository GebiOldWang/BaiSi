//
//  TabBarContorller.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/16.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TabBarContorller.h"
#import "EssenceViewController.h"
#import "NewViewController.h"
#import "FriendViewController.h"
#import "MineViewController.h"
#import "TabBar.h"
#import "NavController.h"

@implementation TabBarContorller

+(void)initialize
{
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary * selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //    appearance  外观属性   统一设置所有tabbaritem 的字体属性
    UITabBarItem * item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}

-(void)viewDidLoad
{
    [self setVC:[[EssenceViewController alloc] init] title:@"精华" imgae:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    [self setVC:[[NewViewController alloc] init] title:@"新帖" imgae:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    [self setVC:[[FriendViewController alloc] init] title:@"关注" imgae:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    [self setVC:[[MineViewController alloc] init] title:@"我" imgae:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    
//    KVC改变程序属性
    [self setValue:[[TabBar alloc] init] forKeyPath:@"tabBar"];
}

-(void)setVC:(UIViewController *)vc title:(NSString *)title imgae:(NSString *)image selectImage:(NSString *)seletImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:seletImage];
//    包装一层nav
    NavController * nav = [[NavController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
