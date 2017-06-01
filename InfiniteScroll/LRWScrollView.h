//
//  LRWScrollView.h
//  InfiniteScroll
//
//  Created by RwLi on 2017/5/24.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

// 一个无限滚动的滚动视图


#import <UIKit/UIKit.h>
@class LRWScrollView;


@interface LRWScrollView : UIScrollView

-(LRWScrollView*(^)(UIView*))add;

@end
