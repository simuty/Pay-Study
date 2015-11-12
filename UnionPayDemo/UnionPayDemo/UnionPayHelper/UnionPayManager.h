//
//  UnionPayManager.h
//  UnionPayDemo
//
//  Created by 51Testing on 15/11/6.
//  Copyright © 2015年 51Testing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnionPayManager : NSObject


+ (instancetype)sharedInstance;

/**
 *  发起支付
 *
 *  @param name       名称
 *  @param price      金额
 *  @param completion 回调处理
 */
- (void)payWithOrderName:(NSString *)name
                   price:(NSString *)price
              completion:(void(^)(BOOL success))completion;

@end
