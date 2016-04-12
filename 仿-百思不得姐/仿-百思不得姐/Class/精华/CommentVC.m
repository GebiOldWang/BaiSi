//
//  CommentVC.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/4/6.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "CommentVC.h"
#import "TopicCell.h"
#import "PublicModel.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "CommentModel.h"
#import "TabelHeaderView.h"
#import "CommentCell.h"

@interface CommentVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITextField *commentText;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * hotComments;
@property (nonatomic, strong) NSMutableArray * nearComments;
//  保存数据的评论的数组
@property (nonatomic, strong) NSArray * save_top_cmt;

@property (nonatomic , assign) NSInteger page;

@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" HightLightImage:@"comment_nav_item_share_icon_click" target:self action:@selector(setBtnClick)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self setHeaderView];
    
    [self refreshTableView];
}

static NSString * const identfy = @"commentCell";

-(void)setHeaderView
{
    TopicCell * cell = [TopicCell createCell];
//    保存评论数组
    self.save_top_cmt = self.self.model.top_cmt;
    self.model.top_cmt = nil ;
    [self.model setValue:@0 forKey:@"cellHeight"];
    
    cell.model = self.model;
    cell.height = self.model.cellHeight;
    CGFloat viewHeight = cell.height + 20;
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewW, viewHeight)];
    self.tableView.tableHeaderView = view ;
    [view addSubview:cell];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = DefaultColor;
//    注册cell的xib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:identfy];
}

-(void)refreshTableView
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}

-(void)getData
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"dataList";
    dict[@"c"] = @"comment";
    dict[@"data_id"] = self.model.ID;
    dict[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.hotComments = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.nearComments = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.nearComments.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        self.page = 1;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)getMoreData
{
    NSInteger page = self.page + 1;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"a"] = @"dataList";
    dict[@"c"] = @"comment";
    dict[@"data_id"] = self.model.ID;
    dict[@"hot"] = @"1";
    dict[@"page"] = @(page);
    CommentModel * cmt = [self.nearComments lastObject];
    dict[@"lasycid"] = cmt.ID;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * newArray = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.nearComments addObjectsFromArray:newArray];
        
        
        self.page = page;
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.nearComments.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }

        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)setBtnClick
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger nearCount = self.nearComments.count;
    if (section == 0) return hotCount ? hotCount : nearCount;
    self.tableView.mj_footer.hidden = (nearCount == 0);
    
    return nearCount ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger nearCount = self.nearComments.count;
    if (hotCount) return 2;
    if (nearCount) return 1;
    return 0;
}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) return hotCount ? @"最热评论":@"最新评论";
//    return @"最新评论";
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TabelHeaderView * hearderview = [TabelHeaderView headerViewWithTabelView:tableView];
    
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        hearderview.title = hotCount ? @"—————— 最热评论 ——————":@"—————— 最新评论 ——————";
    }else if (section == 1){
        hearderview.title = @"—————— 最新评论 ——————";
    }
    return hearderview;
}

-(NSArray *)commentInSction:(NSInteger)section
{
    if (section == 0)
    return self.hotComments.count ? self.hotComments : self.nearComments;

    return self.nearComments;
}

-(CommentModel *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentInSction:indexPath.section][indexPath.row];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:identfy];
    cell.model = [self commentInIndexPath:indexPath];
    return cell;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CommentCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.model = [self commentInIndexPath:indexPath];
//    return cell.model.commentHeight;
//}

//  键盘监听事件
-(void)keyboardChange:(NSNotification *)notify
{// 键盘显示和隐藏frame
    CGRect Frame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    修改约束
    self.bottomSpace.constant = ViewH - Frame.origin.y;
//    键盘的出现的时间
    CGFloat durantion = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    强制布局
    [UIView animateWithDuration:durantion animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.model.top_cmt = self.save_top_cmt;
    [self.model setValue:@0 forKey:@"cellHeight"];
}

//  滚动收件盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
