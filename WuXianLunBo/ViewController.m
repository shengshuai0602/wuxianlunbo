//
//  ViewController.m
//  WuXianLunBo
//
//  Created by lanou3g on 16/2/26.
//  Copyright © 2016年 dss. All rights reserved.
//

#import "ViewController.h"

#import "DSCarouseFigure.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString0 = @"http://imgsrc.baidu.com/forum/pic/item/8cf76c63f6246b60d4f7bfafebf81a4c530fa26a.jpg";
    NSString *urlString1 = @"http://pic1.nipic.com/2008-10-08/200810817375844_2.jpg";
    NSString *urlString2 = @"http://img2.imgtn.bdimg.com/it/u=1121196818,3630381916&fm=21&gp=0.jpg";
    NSString *urlString3 = @"http://img1.3lian.com/img2008/06/019/ych.jpg";
    NSString *urlString4 = @"http://img0.imgtn.bdimg.com/it/u=1178804189,3729685331&fm=21&gp=0.jpg";
    
    
    
    ///本地图片数组
    NSMutableArray *imageArray = [NSMutableArray array];
    ///url图片数组
    NSMutableArray *urlImageArray = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg",i]];
       [imageArray addObject:image];
        
        ///网址加入数组
        [urlImageArray addObject:[NSString stringWithFormat:@"urlString%d",i]];
        
    }
    
 
    
    
    
    
    //无限轮播图
    DSCarouseFigure *dsScrollView = [[DSCarouseFigure alloc]initWithFrame:CGRectMake(10, 30, self.view.frame.size.width - 20, 150)];
   dsScrollView.imageArray = imageArray;
    
    
    [dsScrollView  touchImageIndexBlock:^(NSInteger index) {
       
        NSLog(@"%ld",(long)index);
    }];
    [self.view addSubview:dsScrollView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
