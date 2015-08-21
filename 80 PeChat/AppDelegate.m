//
//  AppDelegate.m
//  77 XMPP框架导入
//
//  Created by peter　 on 15/8/16.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPPFramework.h"
#import "PeNaviController.h"
#import "PeUserInfo.h"
#import "PeXmppTool.h"
#import "DDLog.h"
#import "DDTTYLogger.h"



/*
 实现登陆
 1 初始化xmppStream
 2 连接到服务器 【创一个jid】
 3 连接到服务器之后再发送密码授权
 4 授权成功之后 发送在线消息
 
 
 */


@interface AppDelegate ()


@end




@implementation AppDelegate

#pragma  私有方法



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 打开XMPP的日志
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    
    // Override point for customization after application launch.
   // [self connectToHost];
    [PeNaviController setupNavTheme];
    //从沙盒里面加载数据到单例里面
    
    [[PeUserInfo sharedPeUserInfo] getUserInfoFormBox];
    
    //判断登陆状态 YES 就去主页面
    if([PeUserInfo sharedPeUserInfo].loginStatus ==YES)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = sb.instantiateInitialViewController;
         [[PeXmppTool sharedPeXmppTool ]xmppUserLogin:nil];
    }
    
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
