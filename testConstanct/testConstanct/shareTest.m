//
//  shareTest.m
//  testConstanct
//
//  Created by fly on 2019/5/14.
//  Copyright © 2019 fly. All rights reserved.
//

#import "shareTest.h"
#include <pthread.h>

@implementation shareTest

@synthesize num = _num, count = _count;

-(void)setNum:(NSString*)num {
    self.isSet = true;
    @synchronized (self) {
        NSLog(@"开始设值--旧值 = %@",_num);
        _num = num;
        NSLog(@"结束设值 = %@",_num);
        self.isSet = false;
    }
//    _num = num;
    
    // 初始化
    pthread_rwlock_t rwlock = PTHREAD_RWLOCK_INITIALIZER;
//    // 读模式
//    pthread_rwlock_wrlock(&lock);
//    // 写模式
//    pthread_rwlock_rdlock(&lock);
//    // 读模式或者写模式的解锁
//    pthread_rwlock_unlock(&lock);
    
}

-(NSString*)num {
//    NSLog(@"返回值 = %@",_num);
    NSLog(@"是否正在读写：%d",self.isSet);
    if (self.isSet) {
        @synchronized (self) {
            return _num;
        }
    } else {
        return _num;
    }
    
//    return _num;
}


-(void)setCount:(int)count {
    
    // 有顺序的设值
    dispatch_barrier_async(self.queue, ^{
        NSLog(@"开始设值--旧值 = %d   【%@】",_count,[NSThread currentThread]);
        _count = count;
        NSLog(@"结束设值 = %d",_count);
    });
}

-(int)count {
    __block int temp = 0;
    dispatch_sync(self.queue, ^{
        NSLog(@"取值 = %d, 【%@】",_count, [NSThread currentThread]);
        
        temp = _count;
    });
    return temp;
}


static dispatch_once_t onceToken;
static shareTest *instance;
+(instancetype)shareInstance {
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        instance.num = @"0";
        instance.queue = dispatch_queue_create("ioQueue", DISPATCH_QUEUE_CONCURRENT);
//        NSLog(@"创建新的对象");
    });
    return instance;
}

/*
销毁单例：
 1. 必须把static dispatch_once_t onceToken; 这个拿到函数体外,成为全局的.
*/
+(void)attempDealloc{
    // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    onceToken = 0;
    instance = nil;
}


@end
