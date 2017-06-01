//
//  LRWScrollView.m
//  InfiniteScroll
//
//  Created by RwLi on 2017/5/24.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#define subviewInSCTag  100;


#import "LRWScrollView.h"

@interface LRWScrollView ()

@end

@implementation LRWScrollView


-(LRWScrollView *(^)(UIView *))add{
    return  ^(UIView *v){
        [self addSubview:v];
        self.delegate = self;
        self.pagingEnabled = YES;
         return self;
    };
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
