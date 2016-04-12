//
//  EssenceViewController.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/16.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "EssenceViewController.h"
#import "TagsViewController.h"
#import "SegmentView.h"
#import "PublicTableViewController.h"

@interface EssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic , weak) UIView * redView;

@property (nonatomic, weak) UIButton * selectBtn;

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, weak) UIView * titleView;

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self setUpChildrenVC];
//    设置scrollView
    [self setScrollView];
//    头部标签栏
    [self setSegmentView];
    
}

-(void)setScrollView
{
//      不要自动设置Insets
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView * scrollview = [[UIScrollView alloc] init];
    scrollview.delegate = self;
    scrollview.pagingEnabled = YES;
    scrollview.frame = self.view.bounds;
    [self.view insertSubview:scrollview atIndex:0];
    scrollview.contentSize = CGSizeMake(scrollview.width * self.childViewControllers.count, 0);
    self.scrollView = scrollview;
    [self scrollViewDidEndScrollingAnimation:scrollview];
}

-(void)setUpChildrenVC
{
    PublicTableViewController * table1 = [[PublicTableViewController alloc] init];
    table1.title = @"全部";
    table1.type = TopicTypeAll;
    PublicTableViewController * table2 = [[PublicTableViewController alloc] init];
    table2.title = @"视频";
    table2.type = TopicTypeVideo;
    PublicTableViewController * table3 = [[PublicTableViewController alloc] init];
    table3.title = @"声音";
    table3.type = TopicTypeVoice;
    PublicTableViewController * table4 = [[PublicTableViewController alloc] init];
    table4.title = @"图片";
    table4.type = TopicTypePicture;
    PublicTableViewController * table5 = [[PublicTableViewController alloc] init];
    table5.title = @"段子";
    table5.type = TopicTypeDuanzi;
    
    NSArray * array = @[table1,table2,table3,table4,table5];
    for (NSInteger i = 0 ; i< 5; i++) {
        [self addChildViewController:array[i]];
    }
}

-(void)setNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" HightLightImage:@"MainTagSubIconClick" target:self action:@selector(leftBtnClick)];
    self.view.backgroundColor = DefaultColor;
}

-(void)setSegmentView
{
//    标签栏
    SegmentView * segment = [[SegmentView alloc] init];
    segment.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    segment.frame = CGRectMake(0, BstitleY, self.view.width, BstitleH);
    [self.view addSubview:segment];
    self.titleView = segment;
//    创建指示器
    UIView * redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.height = 2 ;
    redView.tag = -1;
    redView.y = segment.height - redView.height;
    self.redView = redView;
//    内部标签
    
    NSInteger count = 5 ;
    CGFloat W = segment.width / 5;
    CGFloat H = segment.height;
    for (NSInteger i = 0; i < count; i++) {
        CGFloat X = W * i ;
        UIButton * titBtn = [[UIButton alloc] initWithFrame:CGRectMake(X, 0, W, H)];
        titBtn.tag = i;
        UIViewController * vc = self.childViewControllers[i];
        [titBtn setTitle:vc.title forState:UIControlStateNormal];
//        强制更新布局
//        [titBtn layoutIfNeeded];
        [titBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [titBtn addTarget:self action:@selector(titBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [segment addSubview:titBtn];
        
        if (i == 0) {
            titBtn.enabled = NO;
            self.selectBtn = titBtn;
            [titBtn.titleLabel sizeToFit];
            self.redView.width = titBtn.titleLabel.width;
            self.redView.centerX = titBtn.centerX;
        }
    }
    [segment addSubview:redView];
}

-(void)titBtnClick:(UIButton *)sender
{
    self.selectBtn.enabled = YES;
    sender.enabled = NO;
    self.selectBtn = sender;
    [UIView animateWithDuration:0.2 animations:^{
        self.redView.width = sender.titleLabel.width;
        self.redView.centerX = sender.centerX;
    }];
//    改变偏移量
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = sender.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

-(void)leftBtnClick
{
    TagsViewController * tagview = [[TagsViewController alloc] init];
    tagview.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagview animated:YES];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    根据偏移量 获取索引值
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UITableViewController * vc = self.childViewControllers[index];
//    控制器的偏移x值为
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//  默认20
    vc.view.height = scrollView.height; // 不定义高度会少20
    vc.tableView.contentInset = UIEdgeInsetsMake(102, 0, 49, 0);//  上下留有偏移的位置
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;// 滚动条的位置调整为scrollview的位置
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
//    根据偏移量 获取索引值   动画结束去跳转页面
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titBtnClick:self.titleView.subviews[index]];
}

@end
