//
//  TieziController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/10/27.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "TieziController.h"
#import "AppDelegate.h"
#import "Tiezis.h"
#import "InformationController.h"

@interface TieziController (){
    AppDelegate *app;//coredata连接
    NSArray *tiezisarr;//得到查询的数据
    Tiezis *tiezis;//模型
}
@property(copy,nonatomic)NSString *mokuaiming;




@end

@implementation TieziController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationtitle];
    
    app= [ UIApplication sharedApplication].delegate;
    //查找数据 创建实体对象
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Tiezis" inManagedObjectContext:app.managedObjectContext];
    
    //创建抓取数据的对象
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];

    
    [request setPredicate: [NSPredicate predicateWithFormat:@"mokuai=%@ AND tieziID!=nil AND loucengshu = 0 ",self.mokuaiming]];
    NSError *error = nil;
    tiezisarr = [ app.managedObjectContext executeFetchRequest:request error:&error];
    self.automaticallyAdjustsScrollViewInsets =NO;//取消留白
    [self rigthitem];
}
//    @property (nullable, nonatomic, retain) NSString *fabiaoren;
//    @property (nullable, nonatomic, retain) NSString *tiezibiaoti;
//    @property (nullable, nonatomic, retain) NSString *fatieshijian;
//    @property (nullable, nonatomic, retain) NSString *loucengshu;
//    @property (nullable, nonatomic, retain) NSString *mokuai;
//    @property (nullable, nonatomic, retain) NSNumber *tieziID;
//    @property (nullable, nonatomic, retain) NSString *tiezineirong;
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
////行高
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 105;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellID =@"tiezicell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
      
    }
    tiezis = nil;
    tiezis = [tiezisarr objectAtIndex:indexPath.row];
    
    
    UILabel *fatieren=(UILabel *)[cell viewWithTag:1];
    UILabel *biaoti = (UILabel *)[cell viewWithTag:3];
    UILabel *time=(UILabel *)[cell viewWithTag:2];
    
    UIButton *touXiangBTn = (UIButton *)[cell viewWithTag:5];
    //头像Image
    UIImageView *touxiang = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 35, 35)];
    touxiang.layer.cornerRadius = touxiang.frame.size.width / 2;
    touxiang.clipsToBounds = YES;
    
    
    NSArray *touXiangpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *touXiangfilePath = [[touXiangpaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"UserTouXiang%@.png",[tiezis valueForKey:@"fabiaorenId"]]];   // 保存文件的名称
    UIImage *touXiangimg = [UIImage imageWithContentsOfFile:touXiangfilePath];
    if (touXiangimg == nil) {
        touXiangimg = [UIImage imageNamed:@"usermorenbeijing"];
    }
    touxiang.image = touXiangimg;
    
    [touXiangBTn addSubview:touxiang];
    
    time.text = [tiezis valueForKey:@"fatieshijian"];
    fatieren.text = [tiezis valueForKey:@"fabiaoren"];
    biaoti.text = [tiezis valueForKey:@"tiezibiaoti"];

    //imageBtn事件
    [touXiangBTn addTarget:self action:@selector(chaXunUserInformation:event:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
//页面传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //获取indexpath
    NSIndexPath *indexPath = [self.MytabelView indexPathForCell:sender];
    UIViewController *vc=segue.destinationViewController;
    if (indexPath!=nil) {
        tiezis = [tiezisarr objectAtIndex:indexPath.row];
        NSNumber *tieziid = [tiezis valueForKey:@"tieziID"];
        [vc setValue:tieziid forKey:@"tieziid"];
    }

    [vc setValue:self.mokuaiming forKey:@"mokuai"];
    
}

//刷新按钮
- (IBAction)shuaxinbtn:(UIButton *)sender {
    [self viewDidLoad];
    [self.MytabelView reloadData];
}
-(void)navigationtitle{
    if ([self.mokuaiming isEqual:@"2"]) {
        self.navigationItem.title = @"新生指南";
    }
    else if ([self.mokuaiming isEqual:@"4"]) {
        self.navigationItem.title = @"校园招聘";
    }
    else if ([self.mokuaiming isEqual:@"5"]) {
        self.navigationItem.title = @"私人商铺";
    }
    else if ([self.mokuaiming isEqual:@"6"]) {
        
        self.navigationItem.title = @"游玩攻略";
    }
    else if ([self.mokuaiming isEqual:@"10"]) {
        
        self.navigationItem.title = @"街舞社";
    }
    else if ([self.mokuaiming isEqual:@"11"]) {
        
        self.navigationItem.title = @"书法社";
    }else if ([self.mokuaiming isEqual:@"12"]) {
        
        self.navigationItem.title = @"电竞社";
    }else if ([self.mokuaiming isEqual:@"13"]) {
        
        self.navigationItem.title = @"瑜伽社";
    }else if ([self.mokuaiming isEqual:@"14"]) {
        
        self.navigationItem.title = @"手工社";
    }else if ([self.mokuaiming isEqual:@"15"]) {
        
        self.navigationItem.title = @"摄影社";
    }else if ([self.mokuaiming isEqual:@"16"]) {
        
        self.navigationItem.title = @"跆拳道社";
    }
}
//定义右边发帖按钮
-(void)rigthitem{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0,0,50,25);
    addButton.bounds = frame;
    [addButton setTitle:@"发贴" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(fatie) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:addButton];
    
}
-(void)chaXunUserInformation:(id)sender event:(id)event{
    //获取indexpath
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.MytabelView];
    
    NSIndexPath *indexPath = [self.MytabelView indexPathForRowAtPoint: currentTouchPosition];

    tiezis = nil;
    tiezis = [tiezisarr objectAtIndex:indexPath.row];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    InformationController *info = [[InformationController alloc]init];
    info = [storyBoard instantiateViewControllerWithIdentifier:@"information"];
    info.chaKan = tiezis.fabiaorenId;
    
   [self.navigationController pushViewController:info animated:YES];
    
}

-(void)fatie{
    //用segue进入发帖C
    [self performSegueWithIdentifier:@"fatie" sender:self];
}
//每次视图将要出现的时候刷新表
-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
    [self.MytabelView reloadData];
    animated = YES;
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
