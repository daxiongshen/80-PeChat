//
//  PeXmppTool.h
//  80 PeChat
//
//  Created by peter　 on 15/8/19.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "XMPPFramework.h"


typedef enum {
    XmppResultTypeLoginSuccess,//登陆成功
    XmppResultTypeLoginFailure,//登陆失败
    XmppResultNetError,//网络不给力
    XmppResultTypeRegisterFailure,
    XmppResultTypeRegisterSuccess
    
} XmppResultType;

typedef void  (^XmppResultBlock)(XmppResultType type);



@interface PeXmppTool : NSObject
singleton_interface(PeXmppTool);
@property(nonatomic,assign) BOOL registerOperation;
@property(strong,nonatomic) XMPPvCardTempModule *vCard;


//用户登陆
- (void) xmppUserLogin:(XmppResultBlock)resultBlock;

- (void)logout;

- (void) userRegister :(XmppResultBlock)resultBlock;


@end
