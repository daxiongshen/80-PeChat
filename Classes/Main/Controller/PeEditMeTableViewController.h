//
//  PeEditMeTableViewController.h
//  80 PeChat
//
//  Created by peter　 on 15/8/20.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PeEditMeDelegate <NSObject>

-(void)editProfileViewControllerDidSave;

@end

@interface PeEditMeTableViewController : UITableViewController

@property(strong,nonatomic) UITableViewCell *cell;
@property(nonatomic,weak) id<PeEditMeDelegate> delegate;
@end
