//
//  NavigatationController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/17.
//  Copyright (c) 2015年 冯学杰. All rights reserved.
//

#import "NavigatationController.h"

@interface NavigatationController ()

@end

@implementation NavigatationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//进入下一界面隐藏tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(0,0,50,25);
        leftButton.bounds = frame;
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        [leftButton setBackgroundColor:[UIColor clearColor]];
        [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    }

    [super pushViewController:viewController animated:animated];
}

-(void)back
    {
        [self popViewControllerAnimated:YES];
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
