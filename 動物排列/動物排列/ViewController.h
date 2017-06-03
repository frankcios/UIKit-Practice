//
//  ViewController.h
//  動物排列
//
//  Created by Frank on 2017/5/30.
//  Copyright © 2017年 frankc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

- (IBAction)indexChange:(UISegmentedControl *)sender;

@end

