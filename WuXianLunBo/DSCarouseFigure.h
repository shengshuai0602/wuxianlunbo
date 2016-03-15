//
//  DSCarouseFigure.h
//  WuXianLunBo
//
//  Created by lanou3g on 16/2/26.
//  Copyright © 2016年 dss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSCarouseFigure : UIScrollView
//image数组(本地图片)
@property(nonatomic,strong)NSArray *imageArray;
///url图片地址数组
@property(nonatomic,strong)NSArray *urlImageArray;

-(void)touchImageIndexBlock:(void (^)(NSInteger index))block;

@end
