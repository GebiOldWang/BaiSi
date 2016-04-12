//
//  RecommendedVC.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/16.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define selectedModel self.LeftArr[self.LtabelView.indexPathForSelectedRow.row]

#import "RecommendedVC.h"
#import "LeftModel.h"
#import "LeftCell.h"
#import "RightCell.h"
#import "RightModel.h"

#import <MJRefresh.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface RecommendedVC ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *LtabelView;
@property (weak, nonatomic) IBOutlet UITableView *RtableView;
//  左边的数组
@property (nonatomic, strong) NSArray * LeftArr;
@property (nonatomic, strong) NSArray * RightArr;

@property (nonatomic, strong) NSMutableDictionary * parameters;
//  统一请求管理者
@property (nonatomic, strong) AFHTTPSessionManager * manager;

@end

@implementation RecommendedVC

static NSString * const LeftID = @"LeftCell";
static NSString * const RightID = @"RightCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    self.LtabelView.backgroundColor = DefaultColor;
    [self SETuP];
    [self GET];
//    上拉刷新
    self.RtableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(UpLaDate)];
    self.RtableView.mj_footer.hidden = YES;
    self.RtableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(DownLaDate)];
}

-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

-(void)SETuP{
    self.title = @"推荐关注";
    self.view.backgroundColor = DefaultColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.LtabelView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.RtableView.contentInset = self.LtabelView.contentInset;
    
    //    注册
    [self.LtabelView registerNib:[UINib nibWithNibName:NSStringFromClass([LeftCell class]) bundle:nil] forCellReuseIdentifier:LeftID];
    [self.RtableView registerNib:[UINib nibWithNibName:NSStringFromClass([RightCell class]) bundle:nil] forCellReuseIdentifier:RightID];
    
    [SVProgressHUD showWithStatus:@"加载中...请稍后..."];
}
- (void)UpLaDate{
    LeftModel * model = selectedModel;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(model.ID);
    params[@"page"] = @(++model.current_page);
    self.parameters = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.RightArr = [RightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [model.arrays addObjectsFromArray:self.RightArr];
        
        if (self.parameters != params) return ;
        
        [self.RtableView reloadData];
        
        [self checkFooterStatus];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != params) return ;
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
        [self.RtableView.mj_footer endRefreshing];
    }];
}

-(void)DownLaDate
{
    LeftModel * c = selectedModel;
    c.current_page = 1;
    //    点击cell 发送请求  加载右侧数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.ID);
    params[@"page"] = @(c.current_page);
    self.parameters = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.RightArr = [RightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        先清除以前所有的数据
        [c.arrays removeAllObjects];
//         上拉刷新需要每次清除数组数据
        [c.arrays addObjectsFromArray:self.RightArr];
        
        c.total = [responseObject[@"total"] integerValue];
//        如果不是最后一次请求  就反回  不刷新
        if (self.parameters != params) return ;
        
        [self.RtableView reloadData];
        
        [self.RtableView.mj_header endRefreshing];
        
        [self checkFooterStatus];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != params) return ;
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
        [self.RtableView.mj_header endRefreshing];
    }];

}

- (void)GET{

    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"category",@"c":@"subscribe"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
//        P(@"%@",responseObject[@"list"]);
//        利用mjextesion 模型转数组
        self.LeftArr = [LeftModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        tableview刷新
        [self.LtabelView reloadData];
        // 默认选中首行
        [self.LtabelView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.RtableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
}
//  检测底部的状态
-(void)checkFooterStatus
{
    LeftModel * c = selectedModel;
    self.RtableView.mj_footer.hidden = (c.arrays.count == 0);
    if (c.arrays.count == c.total) {
        [self.RtableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.RtableView.mj_footer endRefreshing];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.LtabelView) return self.LeftArr.count;
    
    [self checkFooterStatus];
    
    if ([selectedModel arrays].count) return [selectedModel arrays].count;
    
    return self.RightArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.LtabelView){
        LeftCell * cell = [tableView dequeueReusableCellWithIdentifier:LeftID];
        cell.model = self.LeftArr[indexPath.row];
        return cell;
    }else{
        RightCell * cell = [tableView dequeueReusableCellWithIdentifier:RightID];
        if ([selectedModel arrays].count) {
            cell.model = [selectedModel arrays][indexPath.row];
        }else{
            cell.model = self.RightArr[indexPath.row];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self.RtableView.mj_header endRefreshing];
    [self.RtableView.mj_footer endRefreshing];
    
    if (tableView == self.LtabelView) {
        LeftModel * c = self.LeftArr[indexPath.row];
        
        if (c.arrays.count) {
            [self.RtableView reloadData];
        }else{
            [self.RtableView reloadData];
            
            [self.RtableView.mj_header beginRefreshing];
        }

    }
}

//      tableView返回行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.LtabelView) return 44;
    
    return 60;

}

-(void)dealloc
{
//    停止所有请求
    [self.manager.operationQueue cancelAllOperations];
}

@end
