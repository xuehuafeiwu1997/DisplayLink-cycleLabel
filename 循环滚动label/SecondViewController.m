//
//  SecondViewController.m
//  循环滚动label
//
//  Created by 许明洋 on 2020/9/16.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "SecondViewController.h"
#import "CycleLabel.h"

@interface SecondViewController ()

@property (nonatomic, strong) CycleLabel *titleLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.center = self.view.center;
    [self.view addSubview:self.titleLabel];
}

- (CycleLabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[CycleLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _titleLabel.label.font = [UIFont systemFontOfSize:15];
    _titleLabel.label.textAlignment = NSTextAlignmentCenter;
    _titleLabel.label.textColor = [UIColor blackColor];
    _titleLabel.label.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleLabel.labelText = @"这是一条滚动的测试题目测试题目测试题目测试题目测试题目";
    return _titleLabel;
}

- (void)dealloc {
    NSLog(@"SecondViewController执行了释放方法");
}

@end
