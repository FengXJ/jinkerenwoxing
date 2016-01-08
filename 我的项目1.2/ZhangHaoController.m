//
//  ZhangHaoController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 16/1/8.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "ZhangHaoController.h"
#import "SaveCenterController.h"

@interface ZhangHaoController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation ZhangHaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)backBtn:(id)sender {
    
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)sureBtn:(id)sender {
    SaveCenterController *saveVC = [[SaveCenterController alloc]init];
     [ self presentViewController:saveVC animated: YES completion:nil];
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
