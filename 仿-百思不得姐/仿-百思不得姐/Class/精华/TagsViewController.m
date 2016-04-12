//
//  TagsViewController.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/21.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "TagModel.h"
#import <MJExtension.h>
#import "TagViewCell.h"

@interface TagsViewController ()

@property (nonatomic, strong) NSArray * tags;

@end

@implementation TagsViewController

static NSString * idnetfy = @"tagcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setuptableview];

}

- (void)setuptableview{
    self.navigationItem.title = @"推荐标签";
    
    [SVProgressHUD showWithStatus:@"加载中...请稍后..."];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TagViewCell class]) bundle:nil] forCellReuseIdentifier:idnetfy];
    
    self.tableView.backgroundColor = DefaultColor ;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.tags = [TagModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idnetfy];
    cell.model = self.tags[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


@end
