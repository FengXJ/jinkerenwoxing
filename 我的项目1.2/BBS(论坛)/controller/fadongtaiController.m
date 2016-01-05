//
//  fadongtaiController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/11/2.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "fadongtaiController.h"
#import "weiboshouquanController.h"


@interface fadongtaiController (){
    AppDelegate *app;
}
@property (strong, nonatomic) IBOutlet UITextView *dongtaitextv;
@property(nonatomic,strong) Dongtai *dongtais;
@end

@implementation fadongtaiController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dongtaitextv.text = @"说点什么吧..";
    app = [UIApplication sharedApplication].delegate;
    [self rigthitem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//定义右边发帖按钮
-(void)rigthitem{
    self.navigationItem.title = @"写说说";
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0,0,50,25);
    addButton.bounds = frame;
    [addButton setTitle:@"发表" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(fatie) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:addButton];
    
}
-(void)fatie{
    NSString *dongtaineirong = self.dongtaitextv.text;
    
    if (dongtaineirong !=nil) {
        //使用 实体对象 相当于sqlite的增加
        Dongtai *dongtai = nil;
        //判断是否需要修改 如果是修改 把实体对象赋值给book 进行修改
        if (self.dongtais) {
            dongtai= self.dongtais;
        }
        else {
            dongtai = [NSEntityDescription insertNewObjectForEntityForName:@"Dongtai" inManagedObjectContext:app.managedObjectContext];
        }
        //得到当前时间
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM--dd HH:mm:ss"];
        NSString *datetime = [formatter stringFromDate:[NSDate date]];
        
        //判定帖子ID是否重复
        for (int dongtaiid = 0; dongtaiid>=0; dongtaiid++) {
            NSEntityDescription *entiey = [NSEntityDescription entityForName:@"Dongtai" inManagedObjectContext:app.managedObjectContext];
            NSFetchRequest *request = [[NSFetchRequest alloc]init];
            [request setEntity:entiey];
            [request setPredicate: [NSPredicate predicateWithFormat:@"dongtaiID=%d",dongtaiid]];
            NSError *error2 = nil;
            NSArray *result = [app.managedObjectContext executeFetchRequest:request error:&error2];
            if (result.count == 0) {
                dongtai.dongtaiID = [NSNumber numberWithInt:dongtaiid];
                break;
            }
        }
        //得到用户昵称
        Userzhanghu *usern = nil;
        
        usern = [app returnzhanghu];
        NSString * yonghunicheng = usern.nicheng;
        
        //给实体赋值
        
        dongtai.fabiaoren = yonghunicheng;
        dongtai.huifuren = nil;
        dongtai.fabiaoshijian = datetime;
        dongtai.huifushijian = nil;
        dongtai.zan = [NSNumber numberWithInt:0];
        dongtai.dongtaineirong = dongtaineirong;
        dongtai.yidu = @"0";
        dongtai.fabiaorenId = usern.name;
        dongtai.fatierenname = usern.name;
       
        
//        @dynamic dongtaiID;//动态ID
//        @dynamic fabiaoren;//发表人
//        @dynamic huifuren;//回复人
//        @dynamic fabiaoshijian;//发表时间
//        @dynamic huifushijian;//回复时间
//        @dynamic zan;//赞的数量
//        @dynamic dongtaineirong;//动态内容
//        @dynamic yidu;//是否已读 1读 0否
//        @dynamic touxiangstring; //头像

        NSError * error = nil;
        //保存coredata的数据
        if ([app.managedObjectContext save:&error] ) {
            [self showAlert];
            //如果成功 返回上一个界面
            
        }
        else {
            NSLog(@"添加Books对象到coredata出错 %@",error);
        }
        
    }
}
- (IBAction)weibofenxiang:(UIButton *)sender {
    //先发送到本地 然后分享到微博
    
    weiboshouquanController *weibo = [[weiboshouquanController alloc]init];
    BOOL flag ;
    flag = [weibo fasongweibo:self.dongtaitextv.text];
    if (flag == NO) {
                self.view.window.rootViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"weibodenglu"];
    }else{
    [self fatie];
    }
    
}
-(void)showAlert{
    UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:nil message:@"发表成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [successAlert addAction:SureAction];
    [self presentViewController:successAlert animated:YES completion:nil];
}
@end
