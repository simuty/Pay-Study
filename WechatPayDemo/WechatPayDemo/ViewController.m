//
//  ViewController.m
//  WechatPayDemo
//
//  Created by 51Testing on 15/11/4.
//  Copyright © 2015年 51Testing. All rights reserved.
//

#import "ViewController.h"
#import "WechatPayManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.backgroundColor = [UIColor orangeColor];
    payButton.frame = CGRectMake(100, 100, 100, 60);
    [payButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [payButton setTitle:@"微信支付" forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(weixinSendPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
    
    //注册监听-微信
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealWXpayResult:) name:@"WXpayresult" object:nil];
}

#pragma mark - 微信支付
- (void)weixinSendPay
{
    NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
    [WechatPayManager wxpayWithOrderID:orderno orderTitle:@"测试" amount:@"0.01"];
}

-(void)dealWXpayResult:(NSNotification*)notification{
    
    NSString*result=notification.object;
    if([result isEqualToString:@"1"]){
        //在这里写支付成功之后的回调操作
        NSLog(@"微信支付成功");
    }else{
        //在这里写支付失败之后的回调操作
        NSLog(@"微信支付失败");
    }

}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}


-(void)dealloc{
    //移除监听
    [[NSNotificationCenter defaultCenter ]removeObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
