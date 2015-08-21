//
//  PeUserInfo.m
//  80 PeChat
//
//  Created by peter　 on 15/8/18.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import "PeUserInfo.h"

#define UserKey @"user"
#define UserPwd @"pwd"
#define UserLoginStatus @"loginState"

@implementation PeUserInfo
singleton_implementation(PeUserInfo)
- (void)sandUserInfoToBox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setObject:self.pwd forKey:UserPwd];
     [defaults setBool:self.loginStatus forKey:UserLoginStatus  ];
    [defaults synchronize];
}

- (void)getUserInfoFormBox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.pwd = [defaults objectForKey:UserPwd];
    self.loginStatus = [defaults boolForKey:UserLoginStatus];
}


@end
