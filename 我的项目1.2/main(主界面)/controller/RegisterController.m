//
//  RegisterController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/15.
//  Copyright (c) 2015年 冯学杰. All rights reserved.
//

#import "RegisterController.h"
#import "AppDelegate.h"
#import "Userzhanghu.h"
#import "EaseMob.h"

@interface RegisterController (){
    AppDelegate *app;
    
}

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UINavigationItem *item;
@property (strong, nonatomic) IBOutlet UITextField *nicheng;
@property (strong, nonatomic) IBOutlet UITextField *anquanwenti;

@end

@implementation RegisterController
@synthesize password,username,item;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftitem];
     app = [UIApplication sharedApplication].delegate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftitem{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0,0,50,25);
    addButton.bounds = frame;
    [addButton setTitle:@"返回" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton addTarget:self action:@selector(chaa) forControlEvents:UIControlEventTouchUpInside];
    item.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
}
-(void)chaa{
    [self performSegueWithIdentifier:@"denglu" sender:self];
    
}
- (IBAction)zhuceBtn:(UIButton *)sender {

    NSString *userzhanghuming = username.text;
   
        //implement
        //模型实体
        NSEntityDescription * entity = [NSEntityDescription entityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
        //创建抓取数据的对象
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        //获得编辑框用户名密码
        
        NSString *pwd = password.text;
        NSString *save = self.anquanwenti.text;
        NSString *yonghunicheng = self.nicheng.text;
        //判断用户名是否重复
        [request setPredicate: [NSPredicate predicateWithFormat:@"name=%@",userzhanghuming]];
        NSError *error2 = nil;
        NSArray *result = [app.managedObjectContext executeFetchRequest:request error:&error2];
        
        if (result.count!=0) {
            BOOL flag = NO;
            [self showAlert:@"用户名重复" isSuccess:flag];
        }
        else{
            if (userzhanghuming!=nil && pwd!=nil) {
                //使用 实体对象 相当于sqlite的增加
                Userzhanghu *zhanghu = nil;
                //判断是否需要修改 如果是修改 把实体对象赋值给book 进行修改
                if (self.zhanghus) {
                    zhanghu= self.zhanghus;
                }
                else {
                    zhanghu = [NSEntityDescription insertNewObjectForEntityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
                    
                }
                
                //当普通的对象使用
                zhanghu.name = userzhanghuming;
                zhanghu.pwd = pwd;
                zhanghu.save = save;
                zhanghu.nicheng = yonghunicheng;
                zhanghu.nianling = @"18";
                zhanghu.xinqing = @"心情美不美，写下来吧！";
                zhanghu.sex = @"男";
                zhanghu.xueyuan = @"软件学院";
                zhanghu.touxiangpath = nil;
                
                //定义
                NSError * error = nil;
                //保存coredata的数据
                if ([app.managedObjectContext save:&error] ) {
                    BOOL flag = YES;
                    [self showAlert:@"注册成功" isSuccess:flag];                    //如果成功 返回上一个界面
                    //环信密码固定，因为设备会修改密码
                    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userzhanghuming password:@"baobei2012" withCompletion:^(NSString *username, NSString *password, EMError *error) {
                        if (!error) {
                            NSLog(@"注册成功");
                        }else{
                            NSLog(@"%@",error);
                        }
                    } onQueue:nil];
                    
                }
                else {
                    NSLog(@"添加Books对象到coredata出错 %@",error);
                }
            }
        }
   
     
}

-(void)showAlert:(NSString*)message isSuccess:(BOOL)flag{
    UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (flag) {
            [self performSegueWithIdentifier:@"denglu" sender:self];
        }
    }];
    [successAlert addAction:SureAction];
    [self presentViewController:successAlert animated:YES completion:nil];
}

//点击输入框 使toolbar上弹
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.username) {
        CGFloat offset = self.view.frame.size.height - (self.username.frame.origin.y+self.username.frame.size.height+216+40);
        if (offset<=0) {
            [UIView animateWithDuration:0.1 animations:^{
                CGRect frame = self.view.frame;
                frame.origin.y=offset;
                self.view.frame = frame;
                
            }];
        }
    }else{
    CGFloat offset = self.view.frame.size.height - (self.anquanwenti.frame.origin.y+self.anquanwenti.frame.size.height+216+40);
    if (offset<=0) {
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y=offset;
            self.view.frame = frame;

        }];
    }
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
//限制字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.nicheng == textField)
    {
        if ([toBeString length] > 12) {
            textField.text = [toBeString substringToIndex:13];
            
            return NO;
        }
    }
    if (self.username == textField)
    {
        if ([toBeString length] > 13) {
            textField.text = [toBeString substringToIndex:13];
            
            return NO;
        }
    }
    if (self.password == textField)
    {
        if ([toBeString length] > 13) {
            textField.text = [toBeString substringToIndex:13];
            
            return NO;
        }
    }
    
    return YES;
}

@end
