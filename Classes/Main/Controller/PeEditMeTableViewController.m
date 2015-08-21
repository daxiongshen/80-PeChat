//
//  PeEditMeTableViewController.m
//  80 PeChat
//
//  Created by peter　 on 15/8/20.
//  Copyright (c) 2015年 zgjxpxpyx. All rights reserved.
//

#import "PeEditMeTableViewController.h"

@interface PeEditMeTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation PeEditMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题和默认值
    self.title = self.cell.textLabel.text;
    NSLog(@"%@",self.cell.textLabel.text);
     self.textField.text = self.cell.detailTextLabel.text;
    
    // 右边添加个按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
  
}

-(void)saveBtnClick{
    // 1.更改Cell的detailTextLabel的text
    self.cell.detailTextLabel.text = self.textField.text;
    
    [self.cell layoutSubviews ];
    
    // 2.当前的控制器消失
    [self.navigationController popViewControllerAnimated:YES];
    
    // 调用代理
    if([self.delegate respondsToSelector:@selector(editProfileViewControllerDidSave)]){
        // 通知代理，点击保存按钮
        [self.delegate editProfileViewControllerDidSave];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
