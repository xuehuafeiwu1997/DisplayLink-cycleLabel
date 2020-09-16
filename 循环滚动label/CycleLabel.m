//
//  CycleLabel.m
//  循环滚动label
//
//  Created by 许明洋 on 2020/9/16.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "CycleLabel.h"
#import "CADisplayLink+Block.h"

@interface CycleLabel()

@property (nonatomic) UILabel *secondLabel;
@property (nonatomic) CADisplayLink *timer;

@end

@implementation CycleLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.label];
    self.layer.masksToBounds = YES;
}

- (void)setLabelText:(NSString *)labelText {
    _labelText = labelText;
    self.label.text = labelText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.timer) {
        [self.timer setPaused:YES];
        [self.timer invalidate];
        self.timer = nil;
    }
    if (self.secondLabel && self.secondLabel.superview) {
        [self.secondLabel removeFromSuperview];
    }
    self.label.frame = self.bounds;
    CGRect rect = [_labelText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label.font} context:nil];
    if (rect.size.width > self.frame.size.width) {
        self.label.frame = CGRectMake(0, 0, rect.size.width + 15, self.frame.size.height);
        [self createSecondLabel];
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(cycleLabel)];
        __weak typeof(self) weakSelf = self;
        self.timer = [CADisplayLink displayLinkWithBlock:^{
            [weakSelf cycleLabel];
        }];
        [self.timer setPaused:NO];
        [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)cycleLabel {
    self.label.frame = CGRectMake(self.label.frame.origin.x - 1, self.label.frame.origin.y, self.label.frame.size.width, self.label.frame.size.height);
    self.secondLabel.frame = CGRectMake(CGRectGetMaxX(self.label.frame), self.label.frame.origin.y, self.label.frame.size.width, self.label.frame.size.height);
    if (CGRectGetMaxX(self.label.frame) <= 0) {
        UILabel *tempLabel;
        tempLabel = self.label;
        self.label = self.secondLabel;
        self.secondLabel = tempLabel;
    }
}

- (void)createSecondLabel {
    if (self.secondLabel) {
        self.secondLabel = nil;
    }
    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.label.frame), 0, CGRectGetWidth(self.label.frame), CGRectGetHeight(self.label.frame))];
    self.secondLabel.font = self.label.font;
    self.secondLabel.textAlignment = self.label.textAlignment;
    self.secondLabel.text = self.label.text;
    self.secondLabel.textColor = self.label.textColor;
    self.secondLabel.shadowColor = self.label.shadowColor;
    self.secondLabel.shadowOffset = self.label.shadowOffset;
    self.secondLabel.lineBreakMode = self.label.lineBreakMode;
    
    [self addSubview:self.secondLabel];
}

- (UILabel *)label {
    if (_label) {
        return _label;
    }
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    return _label;
}

- (void)dealloc {
    [self.timer setPaused:YES];
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"cycleLabel执行了释放方法");
}

@end
