//
//  ViewController.m
//  NTImageBrowser
//
//  Created by Nineteen on 10/5/16.
//  Copyright © 2016 Nineteen. All rights reserved.
//

#import "ViewController.h"
#import "NTImageBrowser.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 为UIImageView添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClickAction :)];
    [self.imageView addGestureRecognizer:tap];
}

- (void)imageViewClickAction : (UITapGestureRecognizer *)sender {
    [NTImageBrowser showImageBrowserWithImageView:(UIImageView *)sender.view];
}





@end
