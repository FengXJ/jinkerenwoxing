//
//  luntanController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/22.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "luntanController.h"
#import "AppDelegate.h"
#import "Dongtai.h"
#import "mybutton.h"
#import "Dongtaizan.h"
#import "InformationController.h"

@interface luntanController (){
    AppDelegate *app;
    Dongtai *dongtais;
    NSArray *dongtaisarr;
    CGSize size;//行高
    NSString *username;//当前用户
}
@property (strong, nonatomic) IBOutlet UITableView *mytableview;

@end

@implementation luntanController
-(NSArray *)useCorodatamodelname:(NSString *)model withrequest:(NSString *)requeststring{
    app= [ UIApplication sharedApplication].delegate;
    //查找数据 创建实体对象
    NSEntityDescription * entity = [NSEntityDescription entityForName:model inManagedObjectContext:app.managedObjectContext];
    //创建抓取数据的对象
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    [request setPredicate: [NSPredicate predicateWithFormat:requeststring]];
    NSError *error = nil;
    
    NSArray *result = nil;
    result = [ app.managedObjectContext executeFetchRequest:request error:&error];
    
    return result;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    username = [app chaxunyidengluyonghuming];//获得当前用户
    dongtaisarr = [self useCorodatamodelname:@"Dongtai" withrequest:@"huifuren = nil"];

    [self rigthitem];
//    @dynamic dongtaiID;
//    @dynamic fabiaoren;
//    @dynamic huifuren;
//    @dynamic fabiaoshijian;
//    @dynamic huifushijian;
//    @dynamic zan;
//    @dynamic dongtaineirong;
//    @dynamic yidu;
//    @dynamic touxiangstring;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dongtaisarr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell内存优化
    static NSString *cellID=@"dongtaineirong";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            //        cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        }
    dongtais = nil;
    dongtais = [dongtaisarr objectAtIndex:indexPath.row];
    
    UILabel *fatieren=(UILabel *)[cell viewWithTag:7];
    UILabel *neirong = (UILabel *)[cell viewWithTag:3];
    UILabel *time=(UILabel *)[cell viewWithTag:2];
    UIButton *touXiangBTn = (UIButton *)[cell viewWithTag:8];
    //头像Image
    UIImageView *touxiang = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 35, 35)];
    touxiang.layer.cornerRadius = touxiang.frame.size.width / 2;
    touxiang.clipsToBounds = YES;
    
  
    NSArray *touXiangpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *touXiangfilePath = [[touXiangpaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"UserTouXiang%@.png",[dongtais valueForKey:@"fatierenname"]]];   // 保存文件的名称
    UIImage *touXiangimg = [UIImage imageWithContentsOfFile:touXiangfilePath];
    if (touXiangimg == nil) {
        touXiangimg = [UIImage imageNamed:@"usermorenbeijing"];
    }
    touxiang.image = touXiangimg;
    
    [touXiangBTn addSubview:touxiang];
    
    //imageBtn事件
    [touXiangBTn addTarget:self action:@selector(chaXunUserInformation:event:) forControlEvents:UIControlEventTouchUpInside];
    
    //定义一个子类UIBUTTON 添加属性
    mybutton *zan = [[mybutton alloc]init];
    zan = (mybutton *)[cell viewWithTag:6];
    zan.dongtaiID = [dongtais valueForKey:@"dongtaiID"];
    
    fatieren.text = [dongtais valueForKey:@"fabiaoren"];
    neirong.text = [dongtais valueForKey:@"dongtaineirong"];
    time.text = [dongtais valueForKey:@"fabiaoshijian"];
    
    //查询当前用户是否点过赞 如果点过 显示已点过赞图标
    //没点过 显示没点过赞图标
    
    
    [self panduandianzan:zan.dongtaiID withdangqianyonghu:username withbtn:zan];
   
    //显示赞的数量
    [zan setTitle:[NSString stringWithFormat:@"赞:%@",[dongtais valueForKey:@"zan"]] forState:UIControlStateNormal];

    
    //赞按钮的点击事件
    [zan addTarget:self action:@selector(zanshuliang:) forControlEvents:UIControlEventTouchUpInside];
    
    //调整行高
    UIFont *font = [UIFont systemFontOfSize:14.0];
    neirong.numberOfLines = 0; //动态显示UILabel的行数
    neirong.lineBreakMode = UILineBreakModeWordWrap; //设置UILabel换行模式
    //    假设dataString表示要显示的数据内容，contentLabelWidth表示label实际的宽度，
    size = [neirong.text sizeWithFont:font constrainedToSize:CGSizeMake(300, 1500)  lineBreakMode:UILineBreakModeWordWrap];
    //    上述1500这个值是一个虚数，表示文字可显示的最大数，font 是contentLabel所需使用的字体。
    
    
    return cell;
    
}
//@property (nullable, nonatomic, retain) NSNumber *dongtaiID;
//@property (nullable, nonatomic, retain) NSString *dianzanren;
//@property (nullable, nonatomic, retain) NSString *shifoudianzan;
//判断当前用户是否点过赞 分别设置对应图片
-(BOOL)panduandianzan:(NSNumber *)dongtaiid withdangqianyonghu:(NSString *)user withbtn:(UIButton *)btn{
    BOOL flag;
    NSArray *result = nil;
    app= [ UIApplication sharedApplication].delegate;
    //查找数据 创建实体对象
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Dongtaizan" inManagedObjectContext:app.managedObjectContext];
    //创建抓取数据的对象
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    
    [request setPredicate: [NSPredicate predicateWithFormat:@"dongtaiID = %@ && dianzanren = %@",dongtaiid,user]];
    NSError *error = nil;
    result = [app.managedObjectContext executeFetchRequest:request error:&error];
    if (result.count == 0) {
        
        flag = NO;
        
    }else{
        Dongtaizan *dongtaizan = nil;
        dongtaizan = [result objectAtIndex:0];
        NSString*panduan =  dongtaizan.shifoudianzan;
        if ([panduan isEqual:@"1"]) {
            flag =  YES;
        }
        else{
            flag =  NO;
        }
    }
    [self boolwithzan:flag with:btn];
    return flag;
}
-(void)chaXunUserInformation:(id)sender event:(id)event{
    //获取indexpath
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    
    dongtais = nil;
    dongtais = [dongtaisarr objectAtIndex:indexPath.row];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    InformationController *info = [[InformationController alloc]init];
    info = [storyBoard instantiateViewControllerWithIdentifier:@"information"];
    info.chaKan = dongtais.fabiaorenId;
    
    [self.navigationController pushViewController:info animated:YES];
}

//根据传进的BOOL值 是否点赞 设置图片
-(void)boolwithzan:(BOOL)flag with:(UIButton *)btn{
    if (flag == YES) {
        [btn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"meizan"] forState:UIControlStateNormal];
    }
}
//赞按钮的事件
- (void)zanshuliang:(mybutton *)sender {
//     NSLog(@"%@",sender.dongtaiID);
//    如果没点过赞 点击 图标切换 zan数量+1;
    BOOL flag;
//    flag = [self panduandianzan:sender.dongtaiID withdangqianyonghu:username withbtn:sender];
    
    //然后查询点赞表里有没有点赞
    NSArray *result = nil;
    result =  [self useCorodatamodelname:@"Dongtaizan" withrequest:[NSString stringWithFormat:@"dongtaiID = %@ AND dianzanren = %@ ",(NSString *)sender.dongtaiID,username]];
    //如果结果为0 说明还没点赞 设置点赞数+1 修改图片
    if (result.count == 0) {
       
        Dongtaizan *dongtaizan = nil;
        dongtaizan = [NSEntityDescription insertNewObjectForEntityForName:@"Dongtaizan" inManagedObjectContext:app.managedObjectContext];
        dongtaizan.dongtaiID = sender.dongtaiID;
        dongtaizan.dianzanren = username;
        dongtaizan.shifoudianzan = @"1";//1代表已经点赞
        NSError * error = nil;
        //保存coredata的数据
        if ([app.managedObjectContext save:&error] ) {
            flag = YES;
            [self boolwithzan:flag with:sender];//修改图标
           //使zan+1
            [self zanbianhua:sender withflag:flag];
            
        }
        else {
            NSLog(@"添加Books对象到coredata出错 %@",error);
        }
        
    
        
    }//如果表有数据 那么查询点赞为1还是0
    else{
        Dongtaizan *dongtaizan = nil;
        dongtaizan = [result objectAtIndex:0];
        NSString*panduan =  dongtaizan.shifoudianzan;
        if ([panduan isEqual:@"1"]) {
//            已经点过赞 把赞取消
//            NSLog(@"已经点过赞");
            Dongtaizan *updata = nil;
            updata = dongtaizan;
            updata.dianzanren = dongtaizan.dianzanren;
            updata.shifoudianzan = @"0";
            updata.dongtaiID = dongtaizan.dongtaiID;
            //定义
            NSError * error = nil;
            //保存coredata的数据
            if ([app.managedObjectContext save:&error] ) {
//                NSLog(@"取消赞成功");
                flag = NO;
                [self boolwithzan:flag with:sender];//修改图标
                [self zanbianhua:sender withflag:flag];//使赞-1
            }
            else {
                NSLog(@"添加Books对象到coredata出错 %@",error);
            }
        }
        else{
            //取消过赞 点赞
//            NSLog(@"还没有");
            Dongtaizan *updata = nil;
            updata = dongtaizan;
            updata.dianzanren = dongtaizan.dianzanren;
            updata.shifoudianzan = @"1";
            updata.dongtaiID = dongtaizan.dongtaiID;
            //定义
            NSError * error = nil;
            //保存coredata的数据
            if ([app.managedObjectContext save:&error] ) {
                //                NSLog(@"取消赞成功");
                flag = YES;
                [self boolwithzan:flag with:sender];//修改图标
                [self zanbianhua:sender withflag:flag];//使赞+1
            }
            else {
                NSLog(@"添加Books对象到coredata出错 %@",error);
            }
        }
    }

}
//使zan变化
-(void)zanbianhua:(mybutton *)btn withflag:(BOOL)flag{
    //使zan+1
    NSArray *result1 = nil;
    result1 = [self useCorodatamodelname:@"Dongtai" withrequest:[NSString stringWithFormat:@"dongtaiID = %@ AND huifuren = nil",btn.dongtaiID]];
    Dongtai *dongtai1 = nil;
    dongtai1 = [result1 objectAtIndex:0];
    int zanshuliang = [(dongtai1.zan) intValue];
    if (flag == YES) {
        zanshuliang+=1;
    }else{
        zanshuliang-=1;
    }
    
    //保存赞
    dongtai1.zan = [NSNumber numberWithInt:zanshuliang];
    NSError * error = nil;
    //保存coredata的数据
    if ([app.managedObjectContext save:&error] ) {
        //保存成功
        [self.mytableview reloadData];
    }
    else {
        NSLog(@"保存zan出错 %@",error);
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return size.height + 180;
}
//定义右边发帖按钮
-(void)rigthitem{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    CGRect frame = CGRectMake(0,0,50,25);
    addButton.bounds = frame;
//    [addButton setTitle:@"发表动态" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(fatie) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:addButton];
    
}
-(void)fatie{
    //用segue进入发帖C
    [self performSegueWithIdentifier:@"fadongtai" sender:self];
}
//每次视图将要出现的时候刷新表
-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
    [self.mytableview reloadData];
    animated = YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"1");
}


@end
