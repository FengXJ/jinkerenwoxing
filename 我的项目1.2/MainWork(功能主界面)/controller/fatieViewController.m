//
//  fatieViewController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/10/27.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "fatieViewController.h"
#import "AppDelegate.h"
#import "TieziController.h"
#import "Tiezis.h"


@interface fatieViewController (){
    
    AppDelegate *app;
    NSString *dangqianyonghu ;//已登录用户名
}
@property (strong, nonatomic) IBOutlet UITextField *fatietextfield;
@property (strong, nonatomic) IBOutlet UITextView *neirongtextv;
@property(nonatomic,copy) NSString *mokuai;
@property (strong,nonatomic)NSNumber *tieziid;
@property(nonatomic,strong) Tiezis *tiezis;
@end

@implementation fatieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self rigthitem];
    app = [UIApplication sharedApplication].delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//定义右边发帖按钮
-(void)rigthitem{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0,0,100,25);
    addButton.bounds = frame;
    [addButton setTitle:@"确定发送" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(fatie) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:addButton];
    
}
-(void)fatie{
    dangqianyonghu = [app chaxunyidengluyonghuming];
    
    //    NSEntityDescription *entiey = [NSEntityDescription entityForName:@"Shetuanlianmeng" inManagedObjectContext:app.managedObjectContext];
    //    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //    [request setEntity:entiey];
    NSString *tiezineirong = self.fatietextfield.text;
    if (tiezineirong !=nil) {
        //使用 实体对象 相当于sqlite的增加
        Tiezis *tiezi = nil;
        //判断是否需要修改 如果是修改 把实体对象赋值给book 进行修改
        if (self.tiezis) {
            tiezi= self.tiezis;
        }
        else {
            tiezi = [NSEntityDescription insertNewObjectForEntityForName:@"Tiezis" inManagedObjectContext:app.managedObjectContext];
        }
        //得到当前时间
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM--dd HH:mm:ss"];
        NSString *datetime = [formatter stringFromDate:[NSDate date]];
        //判定帖子ID是否重复
        for (int tieziid = 0; tiezi>=0; tieziid++) {
            NSEntityDescription *entiey = [NSEntityDescription entityForName:@"Tiezis" inManagedObjectContext:app.managedObjectContext];
            NSFetchRequest *request = [[NSFetchRequest alloc]init];
            [request setEntity:entiey];
            [request setPredicate: [NSPredicate predicateWithFormat:@"tieziID=%d",tieziid]];
            NSError *error2 = nil;
            NSArray *result = [app.managedObjectContext executeFetchRequest:request error:&error2];
            if (result.count == 0) {
                tiezi.tieziID = [NSNumber numberWithInt:tieziid];
                break;
            }
        }
        //得到用户昵称
        Userzhanghu *usern = nil;
        
        usern = [app returnzhanghu];
      
        NSString * yonghunicheng = usern.nicheng;
        
        //给实体赋值
        tiezi.tiezibiaoti = self.fatietextfield.text;
        tiezi.mokuai = self.mokuai;
        tiezi.tiezineirong = self.neirongtextv.text;
        tiezi.fabiaoren = yonghunicheng;
        tiezi.loucengshu = [NSNumber numberWithInt:0];
        tiezi.fatieshijian = datetime;
        tiezi.fatierenname = usern.name;
        tiezi.fabiaorenId = usern.name;
        
//        @dynamic fabiaoren;
//        @dynamic tiezibiaoti;
//        @dynamic fatieshijian;
//        @dynamic loucengshu;
//        @dynamic mokuai;
//        @dynamic tieziID;
//        @dynamic tiezineirong;
        //定义
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
-(void)showAlert{
    UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:nil message:@"回复成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [successAlert addAction:SureAction];
    [self presentViewController:successAlert animated:YES completion:nil];
}

@end
