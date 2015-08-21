//
//  PeRegisterVc.m
//  80 PeChat
//
//  Created by peter　 on 15/8/18.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import "PeRegisterVc.h"
#import "PeUserInfo.h"
#import "AppDelegate.h"
#import "PeXmppTool.h"

@interface PeRegisterVc ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@end

@implementation PeRegisterVc
- (IBAction)cancelClick:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)registerBtnClick:(UIButton *)sender {
    //把用户注册数据保存到单例里面
    PeUserInfo *userInfo = [PeUserInfo sharedPeUserInfo];
    userInfo.registerUser = self.userField.text;
    userInfo.registerPwd = self.pwdField.text;
    
    //调用appdelegate 的register
    PeXmppTool *tool = [PeXmppTool sharedPeXmppTool];
    
    
     tool.registerOperation = YES;
    [MBProgressHUD showMessage:@"正在注册中" toView:self.view];
    
    __weak typeof (self) selfVc = self;
    [self.view endEditing:YES];
    [tool userRegister:^(XmppResultType type)
     {
         //连接成功发送注册密码
         [selfVc handleResultType:type];
     }];
    
}

-(void)handleResultType:(XmppResultType) type
{
   
    dispatch_sync(dispatch_get_main_queue(), ^{
         [MBProgressHUD hideHUDForView:self.view];
        //处理注册的结果
        switch (type) {
            case XmppResultNetError:
                [MBProgressHUD showError:@"网络不稳定" toView:self.view];
                break;
                
            case XmppResultTypeRegisterFailure:
                [MBProgressHUD showError:@"用户名重复" toView:self.view];
                break;
            case XmppResultTypeRegisterSuccess:
                [MBProgressHUD showSuccess:@"注册成功" toView:self.view];
                
                //回到上一个控制器 使用代理
                [self dismissViewControllerAnimated:YES completion:nil];
                if ([self.delegate respondsToSelector:@selector(registerViewControllerDidFinishRegister)]) {
                    [self.delegate registerViewControllerDidFinishRegister];
                }
                
                break;
                
            default:
                break;
        }
  
    });
   }


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([UIDevice currentDevice ].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        self.rightConstraint.constant = 10;
        self.rightConstraint.constant = 10;
    }
    //改变约束距离
    self.userField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    self.pwdField.background  =[UIImage stretchedImageWithName:@"operationbox_text"];
    [self.registerBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
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
