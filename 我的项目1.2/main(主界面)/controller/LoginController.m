//
//  LoginController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/14.
//  Copyright (c) 2015年 冯学杰. All rights reserved.
//

#import "LoginController.h"
#import "MainController.h"
#import "AppDelegate.h"
#import "Yidenglu.h"
#import "EaseMob.h"


@interface LoginController (){


    AppDelegate *app;//定义委托
    NSMutableArray *userinformation;
    
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *mation;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *passWard;
@property (strong, nonatomic) IBOutlet UIView *loginView;

- (IBAction)loginButton:(UIButton *)sender;
- (IBAction)sheetBtn:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIImageView *touXiangImageView;
@property (nonatomic,strong) UILabel *nicheng;

@end

@implementation LoginController
@synthesize userName,passWard,loginView;
- (void)viewDidLoad {
    [super viewDidLoad];

    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    app = [UIApplication sharedApplication].delegate;
    float touXiangY;
    
    if (IS_INCH_3_5) {
        touXiangY = 40;
    }else{
        touXiangY = 80;
    }
    
    _touXiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-65, touXiangY, 130, 130)];
    self.touXiangImageView.image = [UIImage imageNamed:@"usermorenbeijing"];
    self.touXiangImageView.layer.cornerRadius = self.touXiangImageView.frame.size.width / 2;
    self.touXiangImageView.clipsToBounds = YES;
    [self.view addSubview:_touXiangImageView];
    
    self.nicheng = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, touXiangY+150, 200, 18)];
    self.nicheng.font = [UIFont fontWithName:@"Blazed" size:18];
    self.nicheng.textAlignment = NSTextAlignmentCenter;
    self.nicheng.hidden = YES;
    [self.view addSubview:self.nicheng];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)weiboshouquan:(UIButton *)sender {
          [self performSegueWithIdentifier:@"weibo" sender:self];
}


- (IBAction)loginButton:(UIButton *)sender {

    //查找数据 创建实体对象
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
    
    //创建抓取数据的对象
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *userzhanghuming = userName.text;
    NSString *password = passWard.text;
    [request setPredicate: [NSPredicate predicateWithFormat:@"name=%@ AND pwd=%@",userzhanghuming,password]];
    NSError *error = nil;
    NSArray *array = [ app.managedObjectContext executeFetchRequest:request error:&error];
    if(array.count == 0){
        [self alert];
    }else {
        //查询已登录表有没有信息
        NSEntityDescription * entityyidenglu = [NSEntityDescription entityForName:@"Yidenglu" inManagedObjectContext:app.managedObjectContext];
        NSFetchRequest * request2 = [[NSFetchRequest alloc] init];
        [request2 setEntity:entityyidenglu];
        
        [request2 setPredicate:[NSPredicate predicateWithFormat:@"name!=nil"]];
        NSError *error2 = nil;
        NSArray *result2 = [app.managedObjectContext executeFetchRequest:request2 error:&error2];
     
        if (result2.count!=0) {
//             1. 实例化查询请求
        
            
            // 4. 输出结果
            for (Yidenglu *yidenglu in result2) {
                
                
                // 删除一条记录
                [app.managedObjectContext deleteObject:yidenglu];
                break;
            }
            
            // 5. 通知_context保存数据
            if ([app.managedObjectContext save:nil]) {
                NSLog(@"删除成功");
            } else {
                NSLog(@"删除失败");
            
            }
        }
            Yidenglu *yidenglu = nil;
            yidenglu = [NSEntityDescription insertNewObjectForEntityForName:@"Yidenglu" inManagedObjectContext:app.managedObjectContext];
            NSError * error = nil;
            yidenglu.name = userzhanghuming;
            //保存coredata的数据
            if ([app.managedObjectContext save:&error] ) {
                //用segue进入主界面tab控制器
                [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userzhanghuming password:password completion:^(NSDictionary *loginInfo, EMError *error) {
                    if (!error && loginInfo) {
                        [self performSegueWithIdentifier:@"Maintab" sender:self];
                        NSLog(@"登陆成功");
                    }
                } onQueue:nil];
                
                
            }
            else {
                NSLog(@"添加Books对象到coredata出错 %@",error);
            }
        

        }
        
    

}
-(void)alert{
    UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:nil message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    
    }];
    
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [successAlert addAction:cancelAction];
    [successAlert addAction:SureAction];
    [self presentViewController:successAlert animated:YES completion:nil];
}


//sheet按钮事件
- (IBAction)sheetBtn:(UIButton *)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"注册" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        [self performSegueWithIdentifier:@"zhuce" sender:self];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"安全中心" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];

}

//点击输入框 使toolbar上弹
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGFloat offset = self.view.frame.size.height - (self.passWard.frame.origin.y+self.passWard.frame.size.height+216+40);
    if (offset<=0) {
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y=offset;
            self.view.frame = frame;
            //            CGRect frame1 =  self.huifutextfield.frame;
            //            frame1.origin.y = offset;
            //            self.mytoolbar.frame=frame1;
        }];
    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    BOOL flag =[app isUser:self.userName.text];
    if (flag) {
        //头像Image

        NSArray *touXiangpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *touXiangfilePath = [[touXiangpaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"UserTouXiang%@.png",self.userName.text]];   // 保存文件的名称
        UIImage *touXiangimg = [UIImage imageWithContentsOfFile:touXiangfilePath];
        if (touXiangimg == nil) {
            touXiangimg = [UIImage imageNamed:@"usermorenbeijing"];
            [UIView animateWithDuration:0.1 animations:^{
                self.nicheng.hidden = YES;
                self.touXiangImageView.image = touXiangimg;
            }];
           
        }else{
            Userzhanghu *user = [app chaXunUserInformationBy:self.userName.text];
            self.nicheng.text = [NSString stringWithFormat:@"欢迎回来！ %@",user.nicheng];
            [UIView animateWithDuration:0.1 animations:^{
                self.nicheng.hidden = NO;
                self.touXiangImageView.image = touXiangimg;
            }];
        }
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.touXiangImageView.image = [UIImage imageNamed:@"usermorenbeijing"];
            self.nicheng.hidden = YES;
            
        }];
    }
}
//输入完成 键盘还原
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y=0.0;
        self.view.frame = frame;
        
    }];
    return YES;
    
}


@end
