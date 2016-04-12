//
//  LoginAndRegisterVC.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/21.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "LoginAndRegisterVC.h"

@interface LoginAndRegisterVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginViewLeftMargin;

@end

@implementation LoginAndRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    副文本 控制颜色属性  字体  大小
//    NSMutableAttributedString * placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号彩虹输入" attributes:nil];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
//                                 NSFontAttributeName:[UIFont systemFontOfSize:14]
//                                 } range:NSMakeRange(0, 1)];
//    self.phoneNumber.attributedPlaceholder = placeholder;
}

- (IBAction)exit {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)cutView:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.LoginViewLeftMargin.constant == 0) {
        [sender setTitle:@"已经注册?" forState:UIControlStateNormal];
        self.LoginViewLeftMargin.constant = -self.view.width;
    }else{
        [sender setTitle:@"快速注册" forState:UIControlStateNormal];
        self.LoginViewLeftMargin.constant = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
