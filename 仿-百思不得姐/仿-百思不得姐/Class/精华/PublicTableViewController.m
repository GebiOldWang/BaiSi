//
//  PublicTableViewController.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/30.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "PublicTableViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "PublicModel.h"
#import "UIImageView+WebCache.h"
#import "TopicCell.h"
#import "CommentVC.h"


@interface PublicTableViewController ()

@property (nonatomic, strong) NSMutableArray * array ;

@property (nonatomic, copy) NSString * maxtime;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSDictionary * params;

@end

@implementation PublicTableViewController

static NSString  * const indentfy = @"newcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self setRefresh];
}

-(NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

-(void)setRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}

-(void)setUpTableView
{
    //    设置内边距
    CGFloat buttom = self.tabBarController.tabBar.height;
    CGFloat top = BstitleH + BstitleY ;
    
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, buttom, 0);
    //    滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //    分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    //    为tableview 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicCell class]) bundle:nil] forCellReuseIdentifier:indentfy];
}

//  下拉刷新
-(void)getData{
    //      结束shang啦刷新
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if (self.params != params) return ;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.array = [PublicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //        [responseObject writeToFile:@"/Users/yinlai/Desktop/duanzi.plist" atomically:YES];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        //        clean pagenumber
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        [self.tableView.mj_header endRefreshing];
    }];
}
//  上拉刷新
-(void)getMoreData
{
    //      结束下啦刷新
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        if (self.params != params) return ;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //        P(@"%@",responseObject[@"list"]);
        NSArray * newArray = [PublicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.array addObjectsFromArray:newArray];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        self.page = page ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.array.count == 0) ;
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:indentfy];
    cell.model = self.array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicModel * model = self.array[indexPath.row];
    return model.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    TopicCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    CommentVC * vc = [[CommentVC alloc] init];
    vc.model = cell.model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end