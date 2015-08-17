//
//  AppDelegate.m
//  77 XMPP框架导入
//
//  Created by peter　 on 15/8/16.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPPFramework.h"


/*
 实现登陆
 1 初始化xmppStream
 2 连接到服务器 【创一个jid】
 3 连接到服务器之后再发送密码授权
 4 授权成功之后 发送在线消息
 
 
 */


@interface AppDelegate ()<XMPPStreamDelegate>
{
    XMPPStream *_xmppStream;
}

-(void) setupXMPPStream;
-(void) connectToHost;
-(void) sendPwdToHost;
-(void) sendOnlineToHost;


@end




@implementation AppDelegate

#pragma  私有方法


#pragma 初始化xmppstream
- (void) setupXMPPStream
{
    _xmppStream = [[XMPPStream alloc]init];
    
    
    
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    
}
- (void)sendPwdToHost

{
    
    //从沙盒获取密码
    
    NSError *err = nil;
    
     NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"];
    [_xmppStream authenticateWithPassword:pwd error:&err];
    if(err)
    {
        NSLog(@"%@",err);
    }
}
- (void)sendOnlineToHost
{
    XMPPPresence *presence = [XMPPPresence presence];
    NSLog(@"%@",presence);
    [_xmppStream sendElement:presence];
}

- (void)connectToHost
{
    if (_xmppStream==nil) {
        [self setupXMPPStream];
    }
    //设置jid
    //从沙盒获取用户名
    NSString *user = [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    
    
    
    XMPPJID *myJid = [XMPPJID jidWithUser:user domain:@"peterpyx" resource:@"iphone"];
    _xmppStream.myJID = myJid;
    
    //设置服务器域名
    _xmppStream.hostName = @"127.0.0.1";//不仅可以是域名 还可以是ip地址
    
    //设置端口 默认5222
    _xmppStream.hostPort = 5222;
    
    
    NSError *err = nil;
    if ([_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&err]==false) {
        NSLog(@"%@",err);
    };
}

#pragma 连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"与主机连接成功");
    [self sendPwdToHost];
    
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"与主机断开连接 %@",error);
    
}
#pragma 授权成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"授权成功");
    [self sendOnlineToHost];
    
    //登陆成功 来到主界面
    
    //此方法实在子线程被调用的 所以要在主线程刷新UI
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                       self.window.rootViewController = storyBoard.instantiateInitialViewController;

                   });
   }

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"授权失败  %@",error);
}

#pragma public

- (void)logout
{
    //注销
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavaliable"];
    [_xmppStream sendElement:offline];
    [_xmppStream disconnect];
    
}

-(void) xmppUserLogin
{
    [self connectToHost];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   // [self connectToHost];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
