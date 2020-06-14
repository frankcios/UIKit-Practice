//
//  ViewController.m
//  UIScrollView-page
//
//  Created by Frank on 2017/6/1.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import "ViewController.h"
#import "InfiniteScrollView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSArray *imageArray = @[@"01.jpg", @"02.jpg", @"03.jpg", @"04.jpg", @"05.jpg"];
    InfiniteScrollView *infiniteScrollView = [[InfiniteScrollView alloc]
                                              initWithFrame:CGRectMake(0, 64.f, self.view.frame.size.width, 300)
                                              imageArray:imageArray];
    [self.view addSubview:infiniteScrollView];
}

@end
