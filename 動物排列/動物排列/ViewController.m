//
//  ViewController.m
//  動物排列
//
//  Created by Frank on 2017/5/30.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import "ViewController.h"

#define kImgWH 50
#define kInitCount 10
#define kInitVSubiewCount 3

@interface ViewController ()

@end

@implementation ViewController

/*
 0 1        0 1 2        0 1 2 3         0 1 2 3 4
 2 3        3 4 5        4 5 6 7         5 6 7 8
 4 5        6 7 8        8
 6 7
 8
 
1.加入按鈕
2.點擊按鈕就會加入圖片到subViews中，並移除原按鈕，圖片位置為原按鈕位置
3.接著也加入按鈕到到subViews中，調用adjustImgPosWithColumns方法做排序
4.排序完成
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self adjustImgPosWithColumns:2 viewCount:kInitCount];
}

- (void)adjustImgPosWithColumns:(int)columns viewCount:(int)viewCount {
    // 1.定義列數＆間距
    // 每行3列
//    int columns = (int)sender.selectedSegmentIndex + 2;
    // 每個動物之間的間距 = (控制器view的寬度 - 列數 * 表情的寬度) / (列數 + 1)
    CGFloat margin = (self.view.frame.size.width - columns * kImgWH) / (columns + 1);
    // 2.定義第一個動物的位置
    CGFloat oneX = margin;
    CGFloat oneY = 100;
    
    // 計算x, y的值
    for (int i = 0; i<viewCount; i++) {
        // i這個位置對應的列數
        int col = i % columns;
        // i這個位置對應的行數
        int row = i / columns;
        
        // 列數 (col) 決定了x
        CGFloat x = oneX + col * (kImgWH + margin);
        // 行數 (row) 決定了y
        CGFloat y = oneY + row * (kImgWH + margin);
        
        // 如果子控件數量小於15
        // 3 (UISegmentedControl, Top Layout Guide, Bottom Layout Guide)
        // 11 (imageView)
        // 1 (button))
        // 就加入UIImageView到view中
        if (self.view.subviews.count < kInitCount+kInitVSubiewCount+1) {
            int no = i % 9 + 1;
            NSString *imgName = [NSString stringWithFormat:@"00%i", no];
            [self addImg:imgName x: x y: y];
        } else {
            // 取出i位置對應的imageView, 設置x, y值
            // 為了跳過 UISegmentedControl, Top Layout Guide, Bottom Layout Guide 三個view
            // 所以要i+3
            if (i<viewCount-3) {
                UIView *child = self.view.subviews[i+kInitVSubiewCount];
                // 印出self.view的子視圖
                NSLog(@"%@", child.class);
                
                // 取出 frame
                CGRect tempF = child.frame;
                // 修改x. y
                tempF.origin = CGPointMake(x, y);
                // 重新賦值
                child.frame = tempF;
            }
        }
        
        if (self.view.subviews.count == kInitCount+kInitVSubiewCount) {
            [self addBtn:x y:y];
        }
    }

    NSLog(@"子控件數量: %zi", self.view.subviews.count);
}

// MARK: 添加ImageView到視圖中
- (void)addImg:(NSString *)icon x:(CGFloat)x y:(CGFloat)y {
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed: icon];
    img.frame = CGRectMake(x, y, kImgWH, kImgWH);
    [self.view addSubview: img];
}

// MARK: 點擊按鈕
- (void)btnClick {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
  
    int columns = (int)_segmentControl.selectedSegmentIndex + 2;
    int viewCount = (int)self.view.subviews.count;
    // 第一次呼叫
    [self adjustImgPosWithColumns:columns viewCount:viewCount];
    for (int i = 0; i < viewCount; i++) {
        if ([self.view.subviews[i] class] == [UIButton class]) {
            [self.view.subviews[i] removeFromSuperview];
        }
    }
    
    // 取出最後一個子控件
    CGPoint finalObjPos = self.view.subviews.lastObject.frame.origin;
    
    // 隨機動物
    int no = arc4random_uniform(9)+1;
    NSString *imgName = [NSString stringWithFormat:@"00%i", no];
    // 加入動物
    [self addImg:imgName x: finalObjPos.x y: finalObjPos.y];
    // 開始動畫
    [UIView commitAnimations];
    // 加入按鈕
    [self addBtn:finalObjPos.x y:finalObjPos.y];
    // 重整排序
    [self adjustImgPosWithColumns:(int)_segmentControl.selectedSegmentIndex + 2 viewCount:(int)self.view.subviews.count];
}

// MARK: 添加按鈕
- (void)addBtn:(CGFloat)x y:(CGFloat)y {
    UIButton *btn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(x, y, kImgWH, kImgWH);
    [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.view addSubview: btn];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents: UIControlEventTouchUpInside];
}

// MARK: 監聽valueChanged事件
- (IBAction)indexChange:(UISegmentedControl *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    int columns = (int)sender.selectedSegmentIndex + 2;
    [self adjustImgPosWithColumns:columns viewCount:(int)self.view.subviews.count];
    
    [UIView commitAnimations];
}

@end
