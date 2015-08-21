//
//  PeBaseLoginVc.m
//  80 PeChat
//
//  Created by peter　 on 15/8/18.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import "PeBaseLoginVc.h"
#import "AppDelegate.h"
#import "PeUserInfo.h"
#import "PeXmppTool.h"


@interface PeBaseLoginVc ()

@end

@implementation PeBaseLoginVc
- (void)login
{
    //登陆
    
    //把用户密码存沙盒  调用appdelegate 的connect 连接登陆
    
    [self.view endEditing:YES];
    
    //登陆之前给提示
    [MBProgressHUD showMessage:@"正在登陆中" toView:self.view];
    PeXmppTool *tool =  [PeXmppTool sharedPeXmppTool];
  
    
    
    tool.registerOperation = NO;
    __weak typeof (self) selfVc = self;
    [tool xmppUserLogin:^(XmppResultType type){
        [selfVc handleResultType:type];
    }];
    
    
}



-(void) handleResultType:(XmppResultType ) type{
    [MBProgressHUD hideHUDForView:self.view];
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       
                       switch (type) {
                           case XmppResultTypeLoginSuccess:
                               PETERLog(@"登陆成功");
                               
                               [self enterMainPage];
                               
                               
                               break;
                           case XmppResultTypeLoginFailure:
                               [MBProgressHUD showError:@"登录失败" toView:self.view];
                               
                               break;
                               
                           case XmppResultNetError:
                               
                               [MBProgressHUD showError:@"网络不给力" toView:self.view];
                               
                           default:
                               break;
                       }
                       
                   });
    
}

- (void)enterMainPage {
    //隐藏模块窗口  记住 一定要调用模态窗口的隐藏
    [PeUserInfo sharedPeUserInfo].loginStatus = YES;
    
    [[PeUserInfo sharedPeUserInfo]sandUserInfoToBox];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = storyBoard.instantiateInitialViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
