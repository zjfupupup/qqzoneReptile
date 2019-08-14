//
//  shareTest.h
//  testConstanct
//
//  Created by fly on 2019/5/14.
//  Copyright © 2019 fly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface shareTest : NSObject
+(instancetype)shareInstance;
+(void)attempDealloc;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, assign) BOOL isSet;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, assign) int count;
@end

NS_ASSUME_NONNULL_END
