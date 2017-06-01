//
//  ViewController.m
//  InfiniteScroll
//
//  Created by RwLi on 2017/5/24.
//  Copyright © 2017年 Renwei Li. All rights reserved.
//

#import "ViewController.h"
#import "LRWScrollView.h"

static NSInteger pre;
static NSInteger go;
static NSInteger selectIdx = 0;

@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) LRWScrollView *sc;
@end

@implementation ViewController
@synthesize sc;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSC];
}
-(void)addSC{
    CGRect frame = {{0,0},{self.view.bounds.size.width*0.8,self.view.bounds.size.height*0.4}};
    
    sc = [[LRWScrollView alloc]initWithFrame:frame];
    
     UIView* v1 = [[UIView alloc]init];
     UIView* v2 = [[UIView alloc]init];
     UIView* v3 = [[UIView alloc]init];
     UIView* v4 = [[UIView alloc]init];
     UIView* v5 = [[UIView alloc]init];
    NSArray *views = @[v1,v2,v3,v4,v5].copy;
   [views enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if (idx<4) {
           
           obj.frame = CGRectMake((idx+1)*frame.size.width, 0, frame.size.width, frame.size.height);
       }else{
            obj.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
       }
       obj.layer.cornerRadius = MIN(frame.size.width, frame.size.height)*0.5;
       obj.backgroundColor =
       [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
       obj.tag = 100+ idx;
       
       UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(obj.bounds.size.width*0.25, obj.bounds.size.height*0.25, frame.size.width*0.5, frame.size.height*0.5)];
       lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)idx];
       lab.textAlignment = NSTextAlignmentCenter;
       lab.font = [ UIFont systemFontOfSize:20];
       lab.backgroundColor =  [UIColor clearColor];
//       NSLog(@"%@",NSStringFromCGPoint(obj.center));
       [obj addSubview:lab];
       
   }];
    
   
    
    sc.add(v1).add(v2).add(v5).add(v3).add(v4);
    sc.contentSize = CGSizeMake(frame.size.width*3, 0);
    sc.center = self.view.center;
    [sc setContentOffset:CGPointMake(sc.bounds.size.width, 0)];
    [self.view addSubview:sc];
    sc.delegate = self;
    sc.showsVerticalScrollIndicator = NO;
    sc.showsHorizontalScrollIndicator = NO;
    
//    
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        CGFloat off = sc.contentOffset.x;
//        off -= sc.bounds.size.width;
//        CGPoint p = CGPointMake(off, 0);
//        [sc setContentOffset:p animated:YES];
//        [self scrollViewDidEndDecelerating:sc];
//    }];
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
   CGFloat offset = scrollView.contentOffset.x ;
   CGFloat width = scrollView.bounds.size.width;
  CGFloat height = scrollView.bounds.size.height;
  double factor = floor((offset + width*0.5)/width);
    if (factor >=2) {
        selectIdx++;
        if (selectIdx>4) {
            selectIdx = 0;
        }
    }else if(factor <= 0){
        selectIdx--;
        if (selectIdx<0) {
            selectIdx = 4;
        }
    }
    else{
        return;
    }
    pre = selectIdx-1;
    go = selectIdx +1 ;
    if (pre < 0) {
        pre = 4;
    }
    if (go >4) {
        go = 0;
    }
    
    for (int i=0; i<5; i++) {
        UIView *v = [sc viewWithTag:100 + i];
        if (i == pre) {
            [v setFrame:CGRectMake(0, 0, width, height)];
        }else if (i == selectIdx){
            [v setFrame:CGRectMake(width, 0, width, height)];
        }else if (i == go){
            [v setFrame:CGRectMake(width*2, 0, width, height)];
        }else{
            int page = (i-go + 5)%5;
            [v setFrame:CGRectMake(width*(2+page), 0, width, height)];
        }
    }
    
    [scrollView setContentOffset:CGPointMake(width, 0)];
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
