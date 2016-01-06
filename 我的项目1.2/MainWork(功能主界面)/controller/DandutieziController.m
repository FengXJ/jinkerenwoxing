//
//  DandutieziController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/10/27.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "DandutieziController.h"
#import "AppDelegate.h"
#import "Tiezis.h"
#import "Userzhanghu.h"
#import "InformationController.h"

@interface DandutieziController (){
    AppDelegate *app;//coredata连接
    NSArray *tiezisarr;//得到查询的数据
    NSString *dangqianyonghu ;//已登录用户名
    CGSize size;//行高
}
@property (strong, nonatomic) IBOutlet UIView *zongdeview;
@property (strong, nonatomic) IBOutlet UITableView *MytablerView;

@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UITextField *huifutextfiled;
@property(nonatomic,strong) Tiezis *tiezis;

//传递过来的 模块名 帖子ID
@property(nonatomic,copy) NSString *mokuai;
@property (strong,nonatomic)NSNumber *tieziid;
@end

@implementation DandutieziController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    app= [ UIApplication sharedApplication].delegate;
    //查找数据 创建实体对象
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Tiezis" inManagedObjectContext:app.managedObjectContext];
    
    //创建抓取数据的对象
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    //    NSString *shetuanxuhao = self.Xuhao;
    
    [request setPredicate: [NSPredicate predicateWithFormat:@"tieziID=%@ AND mokuai=%@",self.tieziid,self.mokuai]];
    NSError *error = nil;
    tiezisarr = [ app.managedObjectContext executeFetchRequest:request error:&error];
    
    
    self.MytablerView.userInteractionEnabled = YES;
    self.huifutextfiled.userInteractionEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets =NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tiezisarr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID =@"tiezicell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        //        cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    }
    
    self.tiezis = nil;
    self.tiezis = [tiezisarr objectAtIndex:indexPath.row];
    //得到控件
    UILabel *time=(UILabel *)[cell viewWithTag:2];
    UILabel *fatieren=(UILabel *)[cell viewWithTag:1];
    UILabel *fatiebiaoti=(UILabel *)[cell viewWithTag:4];
    UILabel *fatieneirong=(UILabel *)[cell viewWithTag:3];
    UILabel *lou=(UILabel *)[cell viewWithTag:5];
    
    UIButton *touXiangBTn = (UIButton *)[cell viewWithTag:6];
    //头像Image
    UIImageView *touxiang = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 35, 35)];
    touxiang.layer.cornerRadius = touxiang.frame.size.width / 2;
    touxiang.clipsToBounds = YES;
    
    
    NSArray *touXiangpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
 
    NSString *touXiangfilePath = [[touXiangpaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"UserTouXiang%@.png",[self.tiezis valueForKey:@"fabiaorenId"]]];   // 保存文件的名称
    UIImage *touXiangimg = [UIImage imageWithContentsOfFile:touXiangfilePath];
    NSLog(@"%@",touXiangfilePath);
    if (touXiangimg == nil) {
        touXiangimg = [UIImage imageNamed:@"usermorenbeijing"];
    }
    touxiang.image = touXiangimg;
    
    [touXiangBTn addSubview:touxiang];

    
    lou.hidden = YES;
    fatiebiaoti.hidden = YES;
    //赋值控件
    NSNumber *louceng = [self.tiezis valueForKey:@"loucengshu"];
    if (![louceng isEqualToNumber:[NSNumber numberWithInt:0]]) {
        lou.hidden = NO;
        lou.text =[NSString stringWithFormat:@"%@ 楼",louceng ];

    }
    fatieneirong.text = [self.tiezis valueForKey:@"tiezineirong"];
    time.text = [self.tiezis valueForKey:@"fatieshijian"];
    fatieren.text = [self.tiezis valueForKey:@"fabiaoren"];
    
    //1楼显示标题
    if (indexPath.row==0) {
        fatiebiaoti.hidden = NO;
        fatiebiaoti.text = [self.tiezis valueForKey:@"tiezibiaoti"];
    }
    //调整行高
    UIFont *font = [UIFont systemFontOfSize:14.0];
    fatieneirong.numberOfLines = 0; //动态显示UILabel的行数
    fatieneirong.lineBreakMode = UILineBreakModeWordWrap; //设置UILabel换行模式
    //    假设dataString表示要显示的数据内容，contentLabelWidth表示label实际的宽度，
    size = [fatieneirong.text sizeWithFont:font constrainedToSize:CGSizeMake(900, 1500)  lineBreakMode:UILineBreakModeWordWrap];
    //    上述1500这个值是一个虚数，表示文字可显示的最大数，font 是contentLabel所需使用的字体。
   
    //imageBtn事件
    [touXiangBTn addTarget:self action:@selector(chaXunUserInformation:event:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}


//回复按钮
- (IBAction)huifubtn:(UIButton *)sender {
    
    if (self.huifutextfiled.text!=nil&&self.huifutextfiled.text.length!=0) {
  
        if (self.tiezis !=nil) {
            //使用 实体对象 相当于sqlite的增加
            Tiezis *tiezi = nil;
            //判断是否需要修改 如果是修改 把实体对象赋值给book 进行修改
            
            
            tiezi = [NSEntityDescription insertNewObjectForEntityForName:@"Tiezis" inManagedObjectContext:app.managedObjectContext];
            
            //得到当前时间
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM--dd HH:mm:ss"];
            NSString *datetime = [formatter stringFromDate:[NSDate date]];
            //判定楼层数 flag判定楼层结束
            BOOL flag = YES;
            for (int louc = 1; flag; louc++) {
                NSEntityDescription *entiey = [NSEntityDescription entityForName:@"Tiezis" inManagedObjectContext:app.managedObjectContext];
                NSFetchRequest *request = [[NSFetchRequest alloc]init];
                [request setEntity:entiey];
                //            从0开始 判定有没有重复楼层 如果重复 +1
                
                [request setPredicate: [NSPredicate predicateWithFormat:@"tieziID=%@ AND loucengshu=%d",self.tieziid,louc]];
                NSError *error2 = nil;
                NSArray *result = [app.managedObjectContext executeFetchRequest:request error:&error2];
                //如果楼层数不重复
                if (result.count == 0) {
                    //定义楼层数
                    tiezi.loucengshu = [NSNumber numberWithInt:louc];
                    //得到用户昵称
                    Userzhanghu *usern = nil;
                    
                    usern = [app returnzhanghu];
                    NSString * yonghunicheng = usern.nicheng;
                    
                    //给实体赋值
                    tiezi.tieziID = self.tieziid;
                    tiezi.tiezibiaoti = nil;
                    tiezi.mokuai = self.mokuai;
                    tiezi.tiezineirong = self.huifutextfiled.text;
                    tiezi.fabiaoren = yonghunicheng;
                    tiezi.fatieshijian = datetime;
                    tiezi.fabiaorenId = usern.name;
//                    tiezi.fatierenname = 
                    
                    
                    //定义
                    NSError * error = nil;
                    //保存coredata的数据
                    if ([app.managedObjectContext save:&error] ) {
                        self.huifutextfiled.text = nil;
                        [self showAlert];
                        [[UIApplication sharedApplication].keyWindow endEditing:YES];
                  
                        
                    }
                    else {
                        NSLog(@"添加Books对象到coredata出错 %@",error);
                    }
                    flag = NO;
                    break;
                }
            }
            
            
            
            //        @dynamic shetuanming;
            //        @dynamic tieziID;
            //        @dynamic tiezineirong;
            //        @dynamic fatieren;
            //        @dynamic fatieshijian;
            //        @dynamic loucengshu;
        }
 
    }
    [self viewDidLoad];
    [self.MytablerView reloadData];
}

//点击输入框 使toolbar上弹
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat offset = self.zongdeview.frame.size.height - (self.toolView.frame.origin.y+self.toolView.frame.size.height+216+40);
    if (offset<=0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y=offset;
            self.zongdeview.frame = frame;
            //            CGRect frame1 =  self.huifutextfield.frame;
            //            frame1.origin.y = offset;
            //            self.mytoolbar.frame=frame1;
        }];
    }
    return YES;
}
//输入完成 键盘还原
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.zongdeview.frame;
        frame.origin.y=0.0;
        self.zongdeview.frame = frame;
        
    }];
    return YES;
    
}

//动态调整行高
- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
     return size.height + 150; // 5即消息上下的空间，可自由调整
}
//    上面的5也是一个虚数,用于设置行距,或者做消息上下空间的调整
//点击row时关闭键盘
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
//刷新按钮
- (IBAction)shuaxinbtn:(UIButton *)sender {

    
    [UIView animateWithDuration:0.3 animations:^{
        [self viewDidLoad];
        [self.MytablerView reloadData];
    }];
   
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(void)chaXunUserInformation:(id)sender event:(id)event{
    //获取indexpath
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.MytablerView];
    
    NSIndexPath *indexPath = [self.MytablerView indexPathForRowAtPoint: currentTouchPosition];
    
    self.tiezis = nil;
    self.tiezis  = [tiezisarr objectAtIndex:indexPath.row];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    InformationController *info = [[InformationController alloc]init];
    info = [storyBoard instantiateViewControllerWithIdentifier:@"information"];
    info.chaKan = self.tiezis.fabiaorenId;

    [self.navigationController pushViewController:info animated:YES];
}
-(void)showAlert{
    UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:nil message:@"回复成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [successAlert addAction:SureAction];
    [self presentViewController:successAlert animated:YES completion:nil];
}

@end
