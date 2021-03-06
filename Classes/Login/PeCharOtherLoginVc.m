//
//  PeCharOtherLoginVc.m
//  80 PeChat
//
//  Created by peter　 on 15/8/17.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import "PeCharOtherLoginVc.h"
#import "AppDelegate.h"
#import "PeUserInfo.h"

@interface PeCharOtherLoginVc ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation PeCharOtherLoginVc


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //判断当前类型
    self.title = @"其他方式登陆";
    if([UIDevice currentDevice ].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        self.leftConstraint.constant = 10;
        self.rightConstraint.constant = 10;
    }
    //改变约束距离
    self.userField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    self.pwdField.background  =[UIImage stretchedImageWithName:@"operationbox_text"];
    [self.loginBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnClick:(UIButton *)sender {
    //登陆
    
    //把用户密码存沙盒  调用appdelegate 的connect 连接登陆
    NSString *user = self.userField.text;
    NSString *pwd = self.pwdField.text;
    
    //这里是保存到单例里面去
    
    PeUserInfo *userinfo = [PeUserInfo sharedPeUserInfo];
    userinfo.user = user;
    userinfo.pwd = pwd;
    
     [super login];
    
    
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)dealloc
{
    //表示控制器还没销毁 存在内存泄漏的问题
    PETERLog(@"%s", __func__);
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
