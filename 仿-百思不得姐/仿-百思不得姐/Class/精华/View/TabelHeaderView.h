//
//  TabelHeaderView.h
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/4/7.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabelHeaderView : UITableViewHeaderFooterView
//  文字
@property (nonatomic , copy) NSString * title;

+(instancetype)headerViewWithTabelView:(UITableView *)tabelView;

@end
