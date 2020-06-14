//
//  InfiniteScrollView.m
//  UIScrollView-page
//
//  Created by  Frank Chuang on 2020/6/14.
//  Copyright © 2020 frankc. All rights reserved.
//

#import "InfiniteScrollView.h"

@interface InfiniteScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIImageView   *leftImageView;
@property (nonatomic, strong) UIImageView   *middleImageView;
@property (nonatomic, strong) UIImageView   *rightImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray       *imageArray;
@property (assign)            NSInteger     count;
@property (assign)            NSInteger     currentIndex;
@property (nonatomic, weak)   NSTimer       *timer;

@end

@implementation InfiniteScrollView

static const int viewNumber = 3;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray<NSString *>*)imageArray {
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = imageArray;
        _count = imageArray.count;
        _currentIndex = 0;
        
        [self createScrollView];
        [self createImageViews];
        [self createPageControl];
        [self createTimer];
    }
    return self;
}

- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    // 設置 scrollView 總內容大小
    _scrollView.contentSize = CGSizeMake(viewNumber*self.frame.size.width, self.frame.size.height);
    // 剛開始的時候，設置偏移量
     _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    // 分頁開啟
    _scrollView.pagingEnabled = YES;
    // 隱藏水平滑動條
    _scrollView.showsHorizontalScrollIndicator = NO;
    // 關閉彈跳效果
    _scrollView.bounces = NO;
    // 設置代理對象
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
}

- (void)createImageViews {
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    _leftImageView.image = [UIImage imageNamed: _imageArray[_count-1]];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
    _middleImageView.image = [UIImage imageNamed: _imageArray[0]];
    _middleImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height)];
    _rightImageView.image = [UIImage imageNamed: _imageArray[1]];
    _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_middleImageView];
    [_scrollView addSubview:_rightImageView];
}

- (void)createPageControl {
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.center = CGPointMake(_scrollView.frame.size.width * 0.5, CGRectGetMaxY(self.frame) - 8);
    _pageControl.bounds = CGRectMake(0, 0, _scrollView.frame.size.width, 44);
    _pageControl.numberOfPages = _count;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageControl.enabled = NO;
      
    [self addSubview:_pageControl];
}

- (void)createTimer {
    
    __weak typeof(self) weakSelf = self;
    
    _timer = [NSTimer timerWithTimeInterval:2.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [weakSelf timerAction];
    }];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction {

    [_scrollView scrollRectToVisible:CGRectMake(2*self.frame.size.width, 0.f, self.frame.size.width, self.frame.size.height) animated:YES];
}

- (void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - scrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 當準備拖動，使定時器失效
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 當停止拖動，創建定時器
    [self createTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = _currentIndex%_count;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
//    NSLog(@"contentOffsetX: %f", scrollView.contentOffset.x);
    
    if (scrollView.contentOffset.x == 2*self.frame.size.width) {

        // 滑到最右邊的時候
        _currentIndex++;
        // 重置圖片內容、修改偏移量
        [self resetImages];
    }
    else if (scrollView.contentOffset.x == 0) {
        
        // 滑到最左邊的時候
        _currentIndex = _currentIndex + _count;
        _currentIndex--;
        
//        if (_currentIndex == 0) {
//            _currentIndex = _count - 1;
//        }
//        else {
//            _currentIndex--;
//        }
        
        [self resetImages];
    }
    
    NSLog(@"currentIndex: %ld", _currentIndex);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x == 2*self.frame.size.width) {
        
        // 滑到最右邊的時候
        _currentIndex++;
        // 重置圖片內容、修改偏移量
        [self resetImages];
    }
    else if (scrollView.contentOffset.x == 0) {
        
        // 滑到最左邊的時候
        _currentIndex = _currentIndex + _count;
        _currentIndex--;
        
        [self resetImages];
    }
    
    NSLog(@"currentIndex: %ld", _currentIndex);
}

#pragma mark - Helpers

- (void)resetImages {
    
//    if (_currentIndex == 0) {
//        _leftImageView.image = [UIImage imageNamed:_imageArray[(_count-1)%_count]];
//    }
//    else {
//        _leftImageView.image = [UIImage imageNamed:_imageArray[(_currentIndex-1)%_count]];
//    }
    
    _leftImageView.image = [UIImage imageNamed:_imageArray[(_currentIndex-1)%_count]];
    _middleImageView.image = [UIImage imageNamed:_imageArray[(_currentIndex)%_count]];
    _rightImageView.image = [UIImage imageNamed:_imageArray[(_currentIndex+1)%_count]];
    
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
}


@end

