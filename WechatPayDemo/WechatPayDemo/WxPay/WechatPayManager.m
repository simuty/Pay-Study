//
//  WechatPayManager.m
//  WechatPay
//
//  Created by 51Testing on 15/11/4.
//  Copyright © 2015年 51Testing. All rights reserved.
//

#import "WechatPayManager.h"
#import "WechatMacro.h"

@implementation WechatPayManager

/**
 *  单一用户
 *
 *  @param orderID    支付订单号
 *  @param orderTitle 订单的商品描述
 *  @param amount     订单总额
 */
+(void)wxpayWithOrderID:(NSString*)orderID
             orderTitle:(NSString*)orderTitle
                 amount:(NSString*)amount{
    
    //微信支付的金额单位是分转化成我们比较常用的'元'
    NSString*realPrice = [NSString stringWithFormat:@"%.f", amount.floatValue * 100];
    
    if(realPrice.floatValue <= 0){
        return;
    }
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo:orderID title:orderTitle price: realPrice];
    
    /**
     *   
     po dict
     {
     appid = wx1adbcf4754b31ba7;
     noncestr = 2E5B6095932E9695EBCFA9EBC5F07E8F;
     package = "Sign=WXPay";
     partnerid = 1248267001;
     prepayid = wx20151104133615b0c6171e710209264559;
     sign = D7D6F0131BB0CE5D798464D2B33FB365;
     timestamp = 1446615375;
     }

     */
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"debug---%@\n\n",debug);
    }else{
        NSLog(@"getDebugifo----%@\n\n",[req getDebugifo]);
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        BOOL status = [WXApi sendReq:req];
        NSLog(@"%d",status);
        
    }
  
}


//客户端提示信息
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}



@end
