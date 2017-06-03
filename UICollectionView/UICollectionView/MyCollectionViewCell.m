//
//  MyCollectionViewCell.m
//  UICollectionView
//
//  Created by Frank on 2017/6/3.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    self = [super initWithFrame:frame];
    if (self)
    {
        // 減 10.0 是為了製造空隙
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w / 3 - 10.0, w / 3 - 30.0)];
        _topImage.backgroundColor = [UIColor whiteColor];
        _topImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_topImage];
        
        // label的 y值 等於image的高度
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, w / 3 - 30.0, w / 3 - 10.0, 20)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [UIColor whiteColor];
        _botlabel.font = [UIFont systemFontOfSize:14];
        _botlabel.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_botlabel];
    }
    
    return self;
}

@end
