//
//  MainWorkController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/17.
//  Copyright (c) 2015年 冯学杰. All rights reserved.
//

#import "MainWorkController.h"
#import "shetuanController.h"

@interface MainWorkController (){
    NSString *xuanzedemokuai;//点击的按钮是哪个模块 传递到下一视图 决定视图显示内容
}

@end

@implementation MainWorkController

- (void)viewDidLoad {
    [super viewDidLoad];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)xinshengzhinan:(UIButton *)sender {
    xuanzedemokuai = @"2";
    [self performSegueWithIdentifier:@"sidtiezi" sender:self];
}

- (IBAction)youwangonglue:(UIButton *)sender {
    xuanzedemokuai = @"6";
    [self performSegueWithIdentifier:@"sidtiezi" sender:self];
}

- (IBAction)sirenshangpu:(UIButton *)sender {
    xuanzedemokuai = @"5";
    [self performSegueWithIdentifier:@"sidtiezi" sender:self];
}

- (IBAction)xiaoyuanzhaopin:(UIButton *)sender {
    xuanzedemokuai = @"4";
    [self performSegueWithIdentifier:@"sidtiezi" sender:self];
}

- (IBAction)shetuanlianmeng:(UIButton *)sender {
//    shetuanController *shetuan = [[shetuanController alloc]init];
//    [self.navigationController pushViewController:shetuan animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    //跳转前被调用。目的用来传递数据（不会中断跳转）
    UIViewController *vc=segue.destinationViewController;
    [vc setValue:xuanzedemokuai forKey:@"mokuaiming"];
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
