//
//  CADisplayLink+Block.m
//  循环滚动label
//
//  Created by 许明洋 on 2020/9/16.
//  Copyright © 2020 许明洋. All rights reserved.
//

#import "CADisplayLink+Block.h"
#import <objc/runtime.h>

@implementation CADisplayLink (Block)

@dynamic invokeBlock;
+ (CADisplayLink *)displayLinkWithBlock:(dispatch_block_t)block {
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(blockInvoke:)];
    link.invokeBlock = block;
    return link;
}

+ (void)blockInvoke:(CADisplayLink *)link {
    if (link.invokeBlock) {
        link.invokeBlock();
    }
}

- (void)setInvokeBlock:(dispatch_block_t)invokeBlock {
    objc_setAssociatedObject(self, @selector(invokeBlock), invokeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (dispatch_block_t)invokeBlock {
    return objc_getAssociatedObject(self, _cmd);
}

@end
