//
//  PeLoginViewController.m
//  80 PeChat
//
//  Created by peter　 on 15/8/18.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import "PeLoginViewController.h"
#import "PeUserInfo.h"
#import "PeRegisterVc.h"
#import "PeNaviController.h"

@interface PeLoginViewController ()<PeRegisterVcDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdLabel;

@end

@implementation PeLoginViewController
- (IBAction)loginBtnClick:(UIButton *)sender {
    
    //保存数据到单例
    //把用户密码存沙盒  调用appdelegate 的connect 连接登陆
    NSString *user = self.userLabel.text;
    NSString *pwd = self.pwdLabel.text;
    
    //这里是保存到单例里面去
    
    PeUserInfo *userinfo = [PeUserInfo sharedPeUserInfo];
    userinfo.user = user;
    userinfo.pwd = pwd;
    
    [super login];
    

    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //获取注册控制器
    id destVc = segue.destinationViewController; //这里获取的是导航控制器
    if ([destVc isKindOfClass:[PeNaviController class]]){
    //设置代理
        
        PeNaviController *nav = destVc;
        //获取根控制器
        
        
        PeRegisterVc *registVc = (PeRegisterVc *)nav.topViewController;
        registVc.delegate = self;
        
    }
}

- (void)registerViewControllerDidFinishRegister
{
    PETERLog(@"完成注册"); //userLabel显示注册的用户名
    self.userLabel.text = [PeUserInfo sharedPeUserInfo].registerUser;
    [MBProgressHUD showSuccess:@"请重新输入密码登陆" toView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //获知上次登陆的用户名
   // NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    [self.pwdLabel addLeftViewWithImage:@"Card_Lock"];
    
    self.pwdLabel.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    
    
    
    NSString *user = [PeUserInfo sharedPeUserInfo].user;
    self.userLabel.text = user;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
