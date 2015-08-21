//
//  PeXmppTool.m
//  80 PeChat
//
//  Created by peter　 on 15/8/19.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import "PeXmppTool.h"
#import "Singleton.h"
#import "XMPPFramework.h"
#import "PeUserInfo.h"


@interface PeXmppTool()<XMPPStreamDelegate>
{
    XMPPStream *_xmppStream;
    XmppResultBlock _resultBlock;
    XMPPvCardTempModule *_vCard;//电子名片
    XMPPvCardCoreDataStorage *_vCardStorage;//电子名片数据存储
    XMPPvCardAvatarModule *_avart;//头像模块
    
}

-(void) setupXMPPStream;
-(void) connectToHost;
-(void) sendPwdToHost;
-(void) sendOnlineToHost;
@end
@implementation PeXmppTool
singleton_implementation(PeXmppTool);


#pragma 初始化xmppstream
- (void) setupXMPPStream
{
    _xmppStream = [[XMPPStream alloc]init];
    
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance ];
    
    //添加电子名片模块
    _vCard = [[XMPPvCardTempModule alloc]initWithvCardStorage:_vCardStorage];
    
    //激活电子名片操作
    [_vCard activate:_xmppStream];
    
    // 添加头像模块
    _avart = [[XMPPvCardAvatarModule alloc ]initWithvCardTempModule:_vCard];

#warning  每一个模块添加之后都需要激活
    
    
    [_avart activate:_xmppStream];
    
    
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    
}
- (void)sendPwdToHost

{
    
    //从沙盒获取密码
    
    NSError *err = nil;
    NSString *pwd = [PeUserInfo sharedPeUserInfo].pwd;
    
    //  NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"];
    [_xmppStream authenticateWithPassword:pwd error:&err];
    if(err)
    {
        PETERLog(@"%@",err);
    }
}
- (void)sendOnlineToHost
{
    XMPPPresence *presence = [XMPPPresence presence];
    PETERLog(@"%@",presence);
    [_xmppStream sendElement:presence];
}

- (void)connectToHost
{
    if (_xmppStream==nil) {
        [self setupXMPPStream];
    }
    //设置jid
    //从沙盒获取用户名
    // NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    
    NSString *user = nil;
    //如果是注册的话
    if (self.registerOperation==true) {
        user = [PeUserInfo sharedPeUserInfo].registerUser;
    }else{
        
        user =  [PeUserInfo sharedPeUserInfo].user;
        
    }
    XMPPJID *myJid = [XMPPJID jidWithUser:user domain:@"peterpyx" resource:@"iphone"];
    _xmppStream.myJID = myJid;
    
    //设置服务器域名
    _xmppStream.hostName = @"127.0.0.1";//不仅可以是域名 还可以是ip地址
    
    //设置端口 默认5222
    _xmppStream.hostPort = 5222;
    
    
    NSError *err = nil;
    if ([_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&err]==false) {
        PETERLog(@"%@",err);
    };
}

#pragma 连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    PETERLog(@"与主机连接成功");
    if(self.registerOperation==true)
    {
        NSString *pwd = [PeUserInfo sharedPeUserInfo].registerPwd;
        [ _xmppStream registerWithPassword:pwd error:nil];
    }
    else
    {
        [self sendPwdToHost];
    }
    
    
}

#pragma mark 连接失败

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    PETERLog(@"与主机断开连接 %@",error);
    if(error && _resultBlock)
    {
        _resultBlock(XmppResultNetError);
    }
    
}
#pragma 授权成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    PETERLog(@"授权成功");
    [self sendOnlineToHost];
    
    //登陆成功 来到主界面
    
    // 回调控制器登录成功
    if(_resultBlock){
        _resultBlock(XmppResultTypeLoginSuccess);
    }
    
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    PETERLog(@"授权失败  %@",error);
    if(_resultBlock)
    {
        _resultBlock(XmppResultTypeLoginFailure);
    }
    
    
}

#pragma mark 注册成功
-(void) xmppStreamDidRegister:(XMPPStream *)sender
{
    PETERLog(@"注册成功");
    if (_resultBlock) {
        _resultBlock(XmppResultTypeRegisterSuccess);
    }
    
}

- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    PETERLog(@"注册失败");
    if (_resultBlock) {
        _resultBlock(XmppResultTypeRegisterFailure);
    }
}
#pragma mark 用户注册


- (void)userRegister :(XmppResultBlock)resultBlock
{
    //先把block存起来
    
    _resultBlock = resultBlock;
    
    [_xmppStream disconnect];
    
    
    
    [self connectToHost];
    
}

- (void)logout
{
    //注销
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavaliable"];
    [_xmppStream sendElement:offline];
    [_xmppStream disconnect];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
       [UIApplication sharedApplication].keyWindow.rootViewController = sb.instantiateInitialViewController;
    
}

-(void) xmppUserLogin:(XmppResultBlock)resultBlock
{
    //先把block存起来
    
    _resultBlock = resultBlock;
    
    [_xmppStream disconnect];
    
    [self connectToHost];
    
}



@end
