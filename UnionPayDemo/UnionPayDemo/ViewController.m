//
//  ViewController.m
//  UnionPayDemo
//
//  Created by 51Testing on 15/11/6.
//  Copyright © 2015年 51Testing. All rights reserved.
//

#import "ViewController.h"
#import "UnionPayManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.backgroundColor = [UIColor orangeColor];
    payButton.frame = CGRectMake(100, 100, 100, 60);
    [payButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [payButton setTitle:@"银联支付" forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(unionPaySendPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];

}

- (void)unionPaySendPay{
    
    [[UnionPayManager sharedInstance] payWithOrderName:@"test" price:@"100" completion:^(BOOL success) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
