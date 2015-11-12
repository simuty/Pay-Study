//
//  ViewController.m
//  AliPayDemo
//
//  Created by 51Testing on 15/11/5.
//  Copyright © 2015年 51Testing. All rights reserved.
//

#import "ViewController.h"
#import "AliPayManagerHeader.h"
#import "AliPayManager.h"

@interface ViewController ()

@end

@implementation ViewController
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *pay = [UIButton buttonWithType:UIButtonTypeCustom];
    pay.frame = CGRectMake(100, 100, 100, 60);
    pay.backgroundColor  =[UIColor orangeColor];
    [pay setTitle:@"支付宝" forState:UIControlStateNormal];
    [pay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pay addTarget:self action:@selector(alipay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pay];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealAlipayResult:) name:@"alipayResult" object:nil];
}


-(void)dealAlipayResult:(NSNotification*)notification{
    
    NSString*result=notification.object;
    if([result isEqualToString:@"9000"]){
        NSLog(@"支付成功");
    }else{
        NSLog(@"支付失败");
    }
}


- (void)alipay{
    
    NSLog(@"支付宝支付");
    [AliPayManager alipayWithProductName:@"Test" amount:@"0.01" tradeNO:[self generateTradeNO] notifyURL:@"www.baidu.com" productDescription:@"TestInfo" itBPay:@"30"];
    
}
#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
