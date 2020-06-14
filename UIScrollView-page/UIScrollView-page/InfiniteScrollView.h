//
//  InfiniteScrollView.h
//  UIScrollView-page
//
//  Created by  Frank Chuang on 2020/6/14.
//  Copyright © 2020 frankc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfiniteScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray<NSString *>*)imageArray;

@end

NS_ASSUME_NONNULL_END
