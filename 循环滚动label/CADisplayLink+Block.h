//
//  CADisplayLink+Block.h
//  循环滚动label
//
//  Created by 许明洋 on 2020/9/16.
//  Copyright © 2020 许明洋. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CADisplayLink (Block)

+ (CADisplayLink *)displayLinkWithBlock:(dispatch_block_t)block;

@property (nonatomic, copy) dispatch_block_t invokeBlock;
@end

NS_ASSUME_NONNULL_END
