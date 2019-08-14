//
//  ViewController.m
//  testConstanct
//
//  Created by fly on 2019/5/13.
//  Copyright © 2019 fly. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "shareTest.h"

@interface ViewController ()<NSCacheDelegate>
@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) NSLayoutConstraint *contentView2InputViewGapLayout;

@property (nonatomic, strong) MASConstraint *contentView2InputViewGapLayout2;

@property (nonatomic, strong) NSCache *cache;

@property (nonatomic, assign) NSInteger num;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    self.num = 0;
//    [self test3];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {    
    [self test7];
//    NSNumber *offset = [self.contentView2InputViewGapLayout2 valueForKey:@"layoutConstant"];
//    NSLog(@"%f",offset.floatValue);
//    MASViewAttribute *attribute = [self.contentView2InputViewGapLayout2 valueForKey:@"firstViewAttribute"];
//    id view = attribute.view;
//    NSLog(@"%f",self.contentView2InputViewGapLayout.constant);
}

- (void)test7 {
    shareTest *test1 = [shareTest shareInstance];
//    test1.num = @"0";
    test1.count = 0;
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
    
    
    dispatch_async(queue2, ^{
//        NSLog(@"queue2线程：%@正在读数据",[NSThread currentThread]);
//        NSLog(@"返回值 = %@",test1.num);
//        test1.num = @"1000";
//        NSLog(@"返回值 = %d",test1.count);
        [test1 count];
    });
    
    dispatch_async(queue1, ^{
        //        NSLog(@"queue1线程：%@正在写数据",[NSThread currentThread]);
//        test1.num = @"10";
        test1.count = 10;
    });
}

- (void)test6 {
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    // 串行队列
    dispatch_queue_t queue3 = dispatch_queue_create("com.demo.serialQueue",DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue3, ^{
        NSLog(@"queue1线程：%@",[NSThread currentThread]);
        
        dispatch_sync(queue2,^{
            
            NSLog(@"3");//
            
        });
        
         NSLog(@"4");//
        
    });
    
//    dispatch_sync(queue3, ^{
//        NSLog(@"queue2线程：%@",[NSThread currentThread]);
//    });
}

-(void)test5 {
    
    //设置缓存中的对象个数最大为3个
    [self.cache setObject:@(self.num) forKey:[NSString stringWithFormat:@"%ldkey",self.num]];
    self.num++;
    NSLog(@"cache = %@",self.cache);
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"cache = %@---obj = %@",cache, obj);
}

- (void)test4 {
    shareTest *test = [shareTest shareInstance];
    [shareTest attempDealloc];
}

- (void)test3 {
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
}

- (void)test2 {
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.view);
        self.contentView2InputViewGapLayout2 = make.bottom.equalTo(self.view).offset(-100);
    }];
    
    id view = [self.contentView2InputViewGapLayout2 valueForKey:@"installedView"];
    if (view) {
        [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(150);
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(view);
        }];
    }
    
}

- (void)test1 {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    self.contentView2InputViewGapLayout = [NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-100];
    
    [self.view addConstraint:self.contentView2InputViewGapLayout];
}

- (void)test {
    NSLayoutConstraint *widthLayoutConstraint = [NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:100];
    NSLayoutConstraint *heightLayoutConstraint = [NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0 constant:500];
    NSLayoutConstraint *xLayoutConstraint = [NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:100];
    NSLayoutConstraint *yLayoutConstraint = [NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:100];
    [self.view addConstraint:widthLayoutConstraint];
    [self.view addConstraint:heightLayoutConstraint];
    [self.view addConstraint:xLayoutConstraint];
    [self.view addConstraint:yLayoutConstraint];

}


-(NSCache *)cache {
    if (!_cache) {
        _cache = [NSCache new];
        _cache.delegate = self;
        [_cache setCountLimit:3];
    }
    return _cache;
}

-(UIView *)redView {
    if (!_redView) {
        _redView = [UIView new];
        _redView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_redView];
    }
    return _redView;
}

-(UIView *)blueView {
    if (!_blueView) {
        _blueView = [UIView new];
        _blueView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_blueView];
    }
    return _blueView;
}


@end
