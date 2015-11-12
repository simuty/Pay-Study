//
//  WechatPayManager.h
//  WechatPay
//
//  Created by 51Testing on 15/11/4.
//  Copyright © 2015年 51Testing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WechatPayManager : NSObject
/**
 *  单一用户
 *
 *  @param orderID    支付订单号
 *  @param orderTitle 订单的商品描述
 *  @param amount     订单总额
 */
+(void)wxpayWithOrderID:(NSString*)orderID
             orderTitle:(NSString*)orderTitle
                 amount:(NSString*)amount;

@end
