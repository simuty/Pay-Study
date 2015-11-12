//
//  UnionPayManager.m
//  UnionPayDemo
//
//  Created by 51Testing on 15/11/6.
//  Copyright © 2015年 51Testing. All rights reserved.
//

#import "UnionPayManager.h"
#import "UPPayPlugin.h"
#import "PayMacro.h"

@interface UnionPayManager()<UPPayPluginDelegate>

@property (readonly, nonatomic) UIViewController *rootViewController;
@property (copy, nonatomic) void (^payCompletion)(BOOL success);

@end

@implementation UnionPayManager
+ (instancetype)sharedInstance
{
    static UnionPayManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[UnionPayManager alloc] init];
    });
    
    return _instance;
}

#define kTnTestURL @"http://202.101.25.178:8080/sim/gettn"

- (NSString *)getTn
{
    NSURL *url = [NSURL URLWithString:kTnTestURL];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    if (response) {
        NSString *tn = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        return tn;
    }
    
    return nil;
}

- (UIViewController *)rootViewController
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (1) {
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

- (void)payWithOrderName:(NSString *)name price:(NSString *)price completion:(void (^)(BOOL success))completion
{
    self.payCompletion = completion;
    NSString *tn = [self getTn];
    [UPPayPlugin startPay:tn mode:kUPPayMode viewController:self.rootViewController delegate:self];
}


#pragma mark - UPPay callback
-(void)UPPayPluginResult:(NSString*)result
{
    BOOL success = [result isEqualToString:@"success"];
    if (success) {
        
        [self alertWithTitle:@"提示" msg:@"支付成功"];
    }else{
        
        [self alertWithTitle:@"提示" msg:@"支付失败"];
    }
    if (self.payCompletion) {
        self.payCompletion(success);
        self.payCompletion = nil;
    }
}

- (void)alertWithTitle:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}


@end
