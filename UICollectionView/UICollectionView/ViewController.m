//
//  ViewController.m
//  UICollectionView
//
//  Created by Frank on 2017/6/3.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"

@interface ViewController ()
{
    CGFloat w;
    CGFloat h;
    UICollectionView *_cView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    w = self.view.bounds.size.width;
    h = self.view.bounds.size.height;
    
    // 建立 UICollectionViewFlowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 設置每一行的間距
    flowLayout.minimumLineSpacing = 10;
    
    // 設置每個 cell 的尺寸
    flowLayout.itemSize = CGSizeMake(w / 3 - 10, w / 3 - 10);
    
    // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    // 建立 UICollectionView
    UICollectionView *cView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, w, h-20) collectionViewLayout:flowLayout];
    cView.backgroundColor = [UIColor yellowColor];
    
    // 註冊 cell
    [cView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    // 註冊 Header
    [cView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    // 註冊 Footer
    [cView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    
    // 設置 header 及 footer 的尺寸
    [flowLayout setHeaderReferenceSize: CGSizeMake(w, 40)];
    [flowLayout setFooterReferenceSize: CGSizeMake(w, 40)];

    // 設置代理對象
    cView.delegate = self;
    cView.dataSource = self;
    
    _cView = cView;
    
    [self.view addSubview:_cView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"調用numberOfSectionsInCollectionView");
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"調用numberOfItemsInSection");
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"調用cellForItemAtIndexPath");
    // 依據前面註冊設置的識別名稱 "Cell" 取得目前使用的 cell
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // 隨機產生圖片
    NSString *imgName = [NSString stringWithFormat:@"0%02zi.png", arc4random() % 10 + 1];
    cell.topImage.image = [UIImage imageNamed:imgName];
    // 產生編號
    NSString *text = [NSString stringWithFormat:@"編號%zi", indexPath.row + 1];
    // 賦值
    cell.botlabel.text = text;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // 建立reusableView對象
    UICollectionReusableView *reusableView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 40)];
    
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor redColor];
        label.text = @"Header";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
    } else if (kind == UICollectionElementKindSectionFooter){
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor blueColor];
        label.text = @"Footer";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    [reusableView addSubview:label];
    
    return reusableView;
}
@end
