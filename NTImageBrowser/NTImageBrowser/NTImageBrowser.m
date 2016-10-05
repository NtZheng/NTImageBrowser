//
//  NTImageBrowser.m
//  NTImageBrowser
//
//  Created by Nineteen on 10/5/16.
//  Copyright © 2016 Nineteen. All rights reserved.
//

#import "NTImageBrowser.h"

#define NTDeviceSize [UIScreen mainScreen].bounds.size
#define NTCurrentWindow [[UIApplication sharedApplication].windows lastObject]

@implementation NTImageBrowser

static CGRect originFrame; // 用于记录imageView本来的frame

+ (void)showImageBrowserWithImageView:(UIImageView *)imageView {
    
    originFrame = [imageView convertRect:imageView.bounds toView:NTCurrentWindow]; // 这个方法用于将imageView原来在父控件中的位置对应到NTCurrentWindow中来
    
    // 1、创建新的UIImageView，原因有两点：第一点是原来的imageView已经被添加了手势,第二点是原来的frame不对新的父控件生效
    UIImageView *newImageView = [[UIImageView alloc]initWithFrame:originFrame];
    newImageView.image = imageView.image;
    newImageView.tag = 19; // 这个标记用于在hide方法中获取到backgroundView（如果不想采用这个方法也可以将backgroundView变成全局变量）
    
    // 2、创建黑色的背景视图
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, NTDeviceSize.width, NTDeviceSize.height)];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImageBrowser :)];
    [backgroundView addGestureRecognizer: tap];
    
    [backgroundView addSubview:newImageView];
    [NTCurrentWindow addSubview:backgroundView];
    
    // 3、执行动画效果
    [UIView animateWithDuration:0.3f animations:^{
        // frame的动画
        CGFloat width = NTDeviceSize.width;
        CGFloat height = NTDeviceSize.width/originFrame.size.width * originFrame.size.height;
        CGFloat x = 0;
        CGFloat y = NTDeviceSize.height/2 - height/2;
        newImageView.frame = CGRectMake(x, y, width, height);
        
        // 透明度的动画
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void)hideImageBrowser :(UIGestureRecognizer *)sender {
    UIView *backgroundView = sender.view;
    UIView *imageView = (UIView *)[backgroundView viewWithTag:19];
    [UIView animateWithDuration:0.3f animations:^{
        // frame的动画
        imageView.frame = originFrame;
        // 透明度的动画
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
