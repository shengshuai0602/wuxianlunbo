//
//  DSCarouseFigure.m
//  WuXianLunBo
//
//  Created by lanou3g on 16/2/26.
//  Copyright © 2016年 dss. All rights reserved.
//

#import "DSCarouseFigure.h"



@interface DSCarouseFigure ()<UIScrollViewDelegate>
///左边
@property(nonatomic,strong)UIImageView *leftImageView;
///中间
@property(nonatomic,strong)UIImageView *midImageView;
///右边
@property(nonatomic,strong)UIImageView *rightImageView;

//记录当前显示的图片下标
@property(nonatomic,assign)NSInteger imageIndex;

//定时器
@property(nonatomic,strong)NSTimer *timer;

//回调block
@property(nonatomic,copy)void (^block)();


@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation DSCarouseFigure


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //创建左边的imageView
        self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //中间
        self.midImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
        //右边
        self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width * 2, 0, frame.size.width, frame.size.height)];
        
        //设置偏移量,显示中间的
        self.contentOffset = CGPointMake(frame.size.width, 0);
        //下标赋值
        self.imageIndex = 1;
        //设置滚动范围
        self.contentSize = CGSizeMake(frame.size.width * 3, frame.size.height);
        
        //添加视图
        [self addSubview:self.leftImageView];
        [self addSubview:self.midImageView];
        [self addSubview:self.rightImageView];
        
        //立即响应
        self.pagingEnabled = YES;
        //设置代理
        self.delegate = self;
        
    }
    return self;
}

#pragma mark -- 重写网络图片数组的setter方法



#pragma mark -- 重写本地图片数组的setter方法 给三个imagView赋值
-(void)setImageArray:(NSArray *)imageArray{
    
    //添加pageControl
    [self performSelector:@selector(addPaageControl) withObject:nil afterDelay:0.5];
    
    NSMutableArray *mutableImageArray = [NSMutableArray arrayWithArray:imageArray];
    [mutableImageArray removeObjectAtIndex:imageArray.count - 1];
    [mutableImageArray insertObject:imageArray.lastObject atIndex:0];
    //数组赋值
    _imageArray = [NSArray arrayWithArray:mutableImageArray];
    
    //image添加
    _leftImageView.image = _imageArray.firstObject;
    _midImageView.image = _imageArray[1];
    _rightImageView.image = _imageArray[2];
    //定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
  
    
}

//定时器调用的方法
-(void)timerAction{
    //设置偏移量
    [self setContentOffset:CGPointMake(self.frame.size.width *  2, 0) animated:YES];
    //用定时器手动调用代理方法
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(timerDidEndAction) userInfo:nil repeats:YES];
   
}

#pragma mark -- 添加pageControl
-(void)addPaageControl{
    _pageControl = [[UIPageControl alloc]init];
    
    _pageControl.numberOfPages = _imageArray.count;
  
    _pageControl.frame  = CGRectMake(270, 150, 100, 20);
    _pageControl.currentPage = 0;
    
    [self.superview addSubview:_pageControl];
    
}


-(void)timerDidEndAction{
    
     [self scrollViewDidEndDecelerating:self];
    
}

#pragma mark -- 代理方法

//滑动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //左右坐标
    NSInteger leftIndex = 0;
    NSInteger rightIndex = 0;
    
    
    if (scrollView.contentOffset.x == 0) {
        //往左滑
        self.imageIndex -- ;
        if (self.imageIndex == 0) {
            leftIndex = _imageArray.count - 1;
            rightIndex = 1;
        }else if (self.imageIndex < 0){
            _imageIndex = _imageArray.count - 1;
            leftIndex = _imageIndex - 1;
            rightIndex = 0;
            
        }else{
            leftIndex = _imageIndex - 1;
            rightIndex = _imageIndex + 1;
        }
        
         }else if (scrollView.contentOffset.x == self.frame.size.width * 2)
    {
        //往右滑
        self.imageIndex ++;
        if (self.imageIndex == _imageArray.count - 1) {
            leftIndex = _imageIndex - 1;
            rightIndex = 0;
            
        }else if (self.imageIndex > _imageArray.count - 1){
            _imageIndex = 0;
            leftIndex = _imageArray.count - 1;
            rightIndex = _imageIndex +1;
        }else{
            leftIndex = _imageIndex - 1;
            rightIndex = _imageIndex +1;
        }
        
        
    }else{
        return;
    }
    
    
    
    //改变偏移量(回到中间的imageView)
   self.contentOffset = CGPointMake(self.frame.size.width, 0);
     //[self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
    
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    //image赋值
    self.leftImageView.image = _imageArray[leftIndex];
    self.midImageView.image = _imageArray[_imageIndex];
    self.rightImageView.image = _imageArray[rightIndex];
    
    //滑动结束后pageControl改变当前的位置
    _pageControl.currentPage =_imageIndex != 0 ?  _imageIndex - 1 : _imageArray.count - 1;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.block) {
        //当存在的时候再调用
        self.block();
    }
    
    
}

-(void)touchImageIndexBlock:(void (^)(NSInteger))block{
    
    __block DSCarouseFigure *men = self;
    self.block = ^(){
        if (block) {
            block((men.imageIndex != 0 ?  men.imageIndex - 1 : men.imageArray.count - 1) );
        }

    };
    
    
    
}

@end
