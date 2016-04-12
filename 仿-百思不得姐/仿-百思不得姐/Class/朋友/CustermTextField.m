//
//  CustermTextField.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/21.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "CustermTextField.h"
#import <objc/runtime.h>

static NSString * const placeholderKeyPth = @"_placeholderLabel.textColor";

@implementation CustermTextField


+(void)initialize
{
//    运行时runtime  苹果的一套c语音   可以访问到隐藏属性
//    unsigned int count = 0 ;
//    Ivar * vars = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = *(vars + i);
//    Ivar ivar = vars[i];
//        P(@"%s",ivar_getName(ivar));
//    }
////    释放
//    free(vars);
}

-(void)awakeFromNib
{
//    UILabel * placeholderLable = [self valueForKeyPath:@"_placeholderLabel"];
//    placeholderLable.textColor = [UIColor grayColor];
    [self resignFirstResponder];
////    光标颜色
    self.tintColor = self.textColor;
}

-(BOOL)becomeFirstResponder
{
    //    修改占位符的颜色
    [self setValue:self.textColor forKeyPath:placeholderKeyPth];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder
{
    //    修改占位符的颜色
    [self setValue:[UIColor grayColor] forKeyPath:placeholderKeyPth];
    return [super resignFirstResponder];
}

@end
