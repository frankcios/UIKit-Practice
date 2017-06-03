//
//  ViewController.m
//  UIScrollView-page
//
//  Created by Frank on 2017/6/1.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import "ViewController.h"
#define imgCount 5

@interface ViewController ()
// 類擴展 又稱匿名分類
// 用來增加私有成員變量與方法
{
    UIPageControl *_pageControl;
    NSArray *imgArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgArray = @[@"05.jpg",@"01.jpg", @"02.jpg", @"03.jpg", @"04.jpg", @"05.jpg",@"01.jpg"];
    
    [self setupViews];
}

- (void)setupViews {
    
    self.automaticallyAdjustsScrollViewInsets = false;

    // 取得螢幕尺寸大小
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    for (int i = 0; i < 7; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * w, 0, w, h);
        imageView.image = [UIImage imageNamed:imgArray[i]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:imageView];
    }

    // height == 0，代表靜止垂直滑動
    _scrollView.contentSize = CGSizeMake(w * 7, 0);
    _scrollView.contentOffset = CGPointMake(w, 0);
    // 分頁開啟
    _scrollView.pagingEnabled = YES;
    // 隱藏水平滑動條
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 設置代理對象
    _scrollView.delegate = self;

    // 添加UIPageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.center = CGPointMake(w * 0.5, h - 16);
    pageControl.bounds = CGRectMake(0, 0, w, 44);
    pageControl.numberOfPages = imgCount;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.enabled = NO;
    
    _pageControl = pageControl;
    [self.view addSubview:pageControl];
}

#pragma mark scrollView開始滑動時調用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = page - 1;
    NSLog(@"%d-----開始滑動", page);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSLog(@"%f", scrollView.contentOffset.x);

    if (scrollView.contentOffset.x == 0) {
        [scrollView setContentOffset: CGPointMake(scrollView.frame.size.width*5, 0) animated:NO];
    }
    else if(scrollView.contentOffset.x == scrollView.frame.size.width*6) {
        [scrollView setContentOffset: CGPointMake(scrollView.frame.size.width, 0) animated:NO];
    }
}

@end
