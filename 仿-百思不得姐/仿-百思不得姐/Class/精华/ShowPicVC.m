//
//  ShowPicVC.m
//  仿-百思不得姐
//
//  Created by 上海银来（集团）有限公司 on 16/3/31.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "ShowPicVC.h"
#import "PublicModel.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "ProgressView.h"

@interface ShowPicVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *scorllView;
@property (nonatomic, weak) UIImageView * imgView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet ProgressView * progressView;

@end

@implementation ShowPicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView * imgView = [[UIImageView alloc] init];
    imgView.userInteractionEnabled = YES;
    [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scorllView addSubview:imgView];
    self.imgView  =  imgView;
    
    [self.saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat width = ViewW;
    CGFloat height = width * self.model.height / self.model.width ;
    if (height > ViewH) {// 图片高度大于整个屏幕
        imgView.frame = CGRectMake(0, 0, width, height);
        self.scorllView.contentSize = CGSizeMake(0, height);
    }else{
        imgView.size = CGSizeMake(width, height);
        imgView.center = CGPointMake(ViewW / 2, ViewH / 2);
    }
    //    // 马上显示当前图片的下载进度
    [self.progressView setProgress:self.model.pictureProgress animated:YES];
    // 下载图片
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.model.large_pic] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save {
    if (self.imgView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还没下载完毕!"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) [SVProgressHUD showErrorWithStatus:@"保存失败"];
    else [SVProgressHUD showSuccessWithStatus:@"保存成功"];
}

@end
