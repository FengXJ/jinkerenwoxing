//
//  ZhangHaoController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 16/1/8.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "ZhangHaoController.h"
#import "SaveCenterController.h"
#import "AppDelegate.h"

@interface ZhangHaoController (){
    AppDelegate *app;
    UIView * errorUserView;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation ZhangHaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     app = [UIApplication sharedApplication].delegate;
    
}
- (IBAction)backBtn:(id)sender {
    
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)sureBtn:(id)sender {
    
    //查找数据 创建实体对象
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
    //创建抓取数据的对象
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *userzhanghuming = self.nameTextField.text;
    [request setPredicate: [NSPredicate predicateWithFormat:@"name=%@",userzhanghuming]];
    NSError *error = nil;
    NSArray *array = [ app.managedObjectContext executeFetchRequest:request error:&error];
    if(array.count == 0){
        errorUserView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-60, SCREEN_HEIGHT/2+15, 120, 30)];
        errorUserView.backgroundColor = [UIColor blackColor];
         errorUserView.hidden = NO;
        [self.view addSubview:errorUserView];
        
        UILabel *errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
        errorLabel.text = @"账户名错误";
        errorLabel.textColor = [UIColor whiteColor];
        errorLabel.textAlignment = NSTextAlignmentCenter;
        [errorUserView addSubview:errorLabel];
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(disapper:) userInfo:nil repeats:NO];
    }else{
        SaveCenterController *saveVC = [[SaveCenterController alloc]init];
        saveVC.UserZhangHaoStr = self.nameTextField.text;
        [self presentViewController:saveVC animated: YES completion:nil];
        
    }
}
-(void)disapper:(id)sender{
    errorUserView.hidden = YES;
    [sender invalidate];
    
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
