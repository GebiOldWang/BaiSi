//
//  TabelHeaderView.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/4/7.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "TabelHeaderView.h"

@interface TabelHeaderView ()

@property(nonatomic, weak) UILabel * label ;

@end

@implementation TabelHeaderView

-(void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = title;
}

+(instancetype)headerViewWithTabelView:(UITableView *)tabelView
{
    static NSString * identfy = @"header";
    TabelHeaderView * header = [tabelView dequeueReusableHeaderFooterViewWithIdentifier:identfy];
    if (!header) {
        header = [[TabelHeaderView alloc] initWithReuseIdentifier:identfy];
    }
    return header;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = DefaultColor;
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGBColor(67, 67, 67);
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = 1;
        label.width = ViewW;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

@end
