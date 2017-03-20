//
//  ViewController.m
//  HMACDemo
//
//  Created by 薛飞龙 on 2017/3/20.
//  Copyright © 2017年 薛飞龙. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"

/* 需要足够的复杂!! */

static NSString * salt = @"dsfy87osdayfYUTS78YT&D78Y8o7sJKHBDJZNMSDBFWER723Q89&**(#*&*(@UHDJASKHDHAGD&Y#@!$&UGDJKQBDJA";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *IDText;
@property (weak, nonatomic) IBOutlet UITextField *PWDText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)Login:(id)sender {
    
    //获取账号密码&发送网络请求
    NSString * userID = self.IDText.text;
    //获取明文密码
    NSString * pwd = self.PWDText.text;
    //进行一次加密!!!
    //直接MD5  --> e10adc3949ba59abbe56e057f20f883e
    //非常不安全,三岁小孩都能破!!!
    //pwd = pwd.md5String;
    //加盐 -- 早期的一种方式 de192ad70141ba379180c45f2cd03fea
    //这种方式也不安全:
    //盐是固定的!!写死在程序里面的,盐一旦泄露就不安全了!!
    //    pwd = [pwd stringByAppendingString:salt].md5String;
    
    
    //HMAC 加密!! 这种加密算法目前非常流行!!而且很多大公司在用!!!
    //注意:在真实的开发中,这个KEY:从服务器获取!!
    //e9cdab82d48dcd37af7734b6617357e6
    //使用一个密钥加密,做两次散列!!
    pwd = [pwd hmacMD5StringWithKey:@"Flonger"];
    
    //模拟发送网络请求  发送的是明文密码!!
    [self isSucessUserID:userID PwdStr:pwd];
    
    NSLog(@"现在的密码是:%@",pwd);
    
}
/*
 服务器的逻辑:
 1.我们服务只会保存用户加密之后的32位的字符串!!!
 2.服务器在用户注册的那一刻!就保存了明文密码加密之后的字符串!!!
 
 */
- (void)isSucessUserID:(NSString *)UserID PwdStr:(NSString *)pwdStr{
    if ([UserID isEqualToString:@"Flonger"]&&
        [pwdStr isEqualToString:@"acbfc6ba994b51cfed18921ea4b9cab4"]) {
        NSLog(@"登录成功!!");
    }else{
        NSLog(@"登录失败");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
