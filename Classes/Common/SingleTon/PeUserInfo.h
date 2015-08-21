//
//  PeUserInfo.h
//  80 PeChat
//
//  Created by peter　 on 15/8/18.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

//使用单例
@interface PeUserInfo : NSObject
singleton_interface( PeUserInfo);

@property(nonatomic,copy) NSString *user;
@property(nonatomic,copy) NSString *pwd;

@property(nonatomic,assign) BOOL loginStatus;

@property(nonatomic,copy) NSString *registerUser;//注册用户名

@property(nonatomic,copy) NSString *registerPwd;


-(void) sandUserInfoToBox;


-(void) getUserInfoFormBox;
@end
