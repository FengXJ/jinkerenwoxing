//
//  MainController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/17.
//  Copyright (c) 2015年 冯学杰. All rights reserved.
//

#import "MainController.h"
#import "NavigatationController.h"



@interface MainController ()

@end

@implementation MainController

-(void)loadTabbarController{
    //从stroryboard读取控制器
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainWorkController *mainW = [[MainWorkController alloc]init];
    mainW = [storyBoard instantiateViewControllerWithIdentifier:@"mainwork"];
    [self setController:mainW withTitle:@"主界面" withNormalImage:@"Main" withSelectImage:@"Main_select"];
    
    luntanController *bbsW = [[luntanController alloc]init];
    bbsW = [storyBoard instantiateViewControllerWithIdentifier:@"bbs"];
    [self setController:bbsW withTitle:@"动态" withNormalImage:@"Main" withSelectImage:@"Main_select"];
    
    FriendController *friendc = [[FriendController alloc]init];
    friendc = [storyBoard instantiateViewControllerWithIdentifier:@"friend"];
    [self setController:friendc withTitle:@"好友" withNormalImage:@"Main" withSelectImage:@"Main_select"];
    
    InformationController *informationc = [[InformationController alloc]init];
    informationc = [storyBoard instantiateViewControllerWithIdentifier:@"information"];
    [self setController:informationc withTitle:@"个人信息" withNormalImage:@"Main" withSelectImage:@"Main_select"];
    
    
}
//创建一个tabbar的具体子控制器对象
-(void)setController:(UIViewController *)vc1
           withTitle:(NSString *)title
     withNormalImage:(NSString *)normal
     withSelectImage:(NSString *)selectImage
{
    //封装头部导航控制器
    NavigatationController *nav = [[NavigatationController alloc]initWithRootViewController:vc1];
    //vc1.navigationItem.title = title;
    //往根控制器添加子控制器
    //vc1.tabBarItem.title = title;
    vc1.title = title;
    UIImage *homeImage = [UIImage imageNamed:normal];
    homeImage = [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.image = homeImage;
    UIImage *homeSelectedImage = [UIImage imageNamed:selectImage];
    homeSelectedImage = [homeSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc1.tabBarItem.selectedImage = homeSelectedImage;

    [self addChildViewController:nav];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTabbarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
