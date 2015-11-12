//
//  WechatMacro.h
//  WechatPay
//
//  Created by 51Testing on 15/11/4.
//  Copyright © 2015年 51Testing. All rights reserved.
//

#ifndef WechatMacro_h
#define WechatMacro_h


//===================== 微信账号帐户资料=======================

#import "payRequsestHandler.h"         //导入微信支付类
#import "WXApi.h"

#define APP_ID          @"wx1adbcf4754b31ba7"               //APPID
#define APP_SECRET      @"b42e67ad02507810763c0256b1d2fb89" //appsecret
//商户号，填写商户对应参数
#define MCH_ID          @"1248267001"
//商户API密钥，填写相应参数
#define PARTNER_ID      @"3B689B0104B9D065FAEDDFE320444179"
//支付结果回调页面
#define NOTIFY_URL      @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"



#endif /* WechatMacro_h */
