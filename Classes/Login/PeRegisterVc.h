//
//  PeRegisterVc.h
//  80 PeChat
//
//  Created by peter　 on 15/8/18.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PeRegisterVcDelegate<NSObject>

-(void) registerViewControllerDidFinishRegister;

@end


@interface PeRegisterVc : UIViewController
@property(nonatomic,weak) id<PeRegisterVcDelegate> delegate;
@end
