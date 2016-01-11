//
//  SaveCenterController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 16/1/6.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "SaveCenterController.h"
#import "AppDelegate.h"
#import "SaveTableViewCell.h"
#import "Userzhanghu.h"

@interface SaveCenterController ()<UITableViewDataSource,UITableViewDelegate>{
    AppDelegate *app;
    UIView * errorUserView;
    UILabel *errorLabel;
    Userzhanghu *user;
}

@property (nonatomic,strong) UITableView *bodyTableview;

@property (nonatomic,strong) UIButton *sureBtn;

@end

@implementation SaveCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *BGimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20+44, SCREEN_WIDTH, SCREEN_HEIGHT)];
    BGimageView.image = [UIImage imageNamed:@"NewFeature-1"];
    BGimageView.userInteractionEnabled = YES;
    [self.view addSubview:BGimageView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    headView.backgroundColor =LCHexColor(0xfafafa);
    [self.view addSubview:headView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    titleLabel.text = @"修改密码";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 44)];
    backbtn.backgroundColor = [UIColor clearColor];
    [backbtn setTitle:@"back" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [headView addSubview:backbtn];
    [backbtn addTarget:self action:@selector(testBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.bodyTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) style:UITableViewStylePlain];
    self.bodyTableview.delegate = self;
    self.bodyTableview.dataSource = self;
    self.bodyTableview.backgroundColor = [UIColor clearColor];
    [BGimageView addSubview:self.bodyTableview];
    [self setExtraCellLineHidden:self.bodyTableview];
    
    self.sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 240, SCREEN_WIDTH-30, 44)];
    self.sureBtn.backgroundColor = LCHexColor(0x666666);
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [BGimageView addSubview:self.sureBtn];
    [self.sureBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    
    errorUserView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-60, SCREEN_HEIGHT/2+15, 120, 30)];
    errorUserView.backgroundColor = [UIColor blackColor];
    errorUserView.hidden = YES;
    [self.view addSubview:errorUserView];
    
    errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    errorLabel.textColor = [UIColor whiteColor];
    errorLabel.textAlignment = NSTextAlignmentCenter;
    [errorUserView addSubview:errorLabel];
    
    app = [UIApplication sharedApplication].delegate;
    
}

-(void)sure:(id)sender{
    NSIndexPath *saveIndexpath = [NSIndexPath indexPathForRow:1 inSection:0];
    SaveTableViewCell *saveCell = [self.bodyTableview cellForRowAtIndexPath:saveIndexpath];
    NSString *saveText = saveCell.contentTextField.text;
    
    NSIndexPath *pwdOneIndex = [NSIndexPath indexPathForRow:0 inSection:1];
    SaveTableViewCell *pwdOneCell = [self.bodyTableview cellForRowAtIndexPath:pwdOneIndex];
    NSString *pwdOneStr = pwdOneCell.contentTextField.text;
    
    NSIndexPath *pwdTwoIndex  = [NSIndexPath indexPathForRow:1 inSection:1];
    SaveTableViewCell *pwdTwoCell = [self.bodyTableview cellForRowAtIndexPath:pwdTwoIndex];
    NSString *pwdTwoStr = pwdTwoCell.contentTextField.text;
    
    if ([pwdOneStr isEqual:pwdTwoStr]) {
        //查找数据 创建实体对象
        NSEntityDescription * entity = [NSEntityDescription entityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
        //创建抓取数据的对象
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        NSString *userzhanghuming = self.UserZhangHaoStr;
        
        [request setPredicate: [NSPredicate predicateWithFormat:@"name=%@ AND save=%@",userzhanghuming,saveText]];
        NSError *error = nil;
        NSArray *array = [ app.managedObjectContext executeFetchRequest:request error:&error];
        if(array.count == 0){
            errorLabel.text = @"安全问题输入错误";
            errorUserView.hidden = NO;
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(disapper:) userInfo:nil repeats:NO];
        }else{
            //修改原密码
            user = nil;
            user = [array objectAtIndex:0];
            user.pwd = pwdOneStr;
            
            NSError *error = nil;
            if ([app.managedObjectContext save:&error] ) {
                NSLog(@"保存成功");
            }
            else {
                NSLog(@"修改安全问题出错 %@",error);
            }
        }
    }else{
        errorLabel.text = @"两次密码不一致";
        errorUserView.hidden = NO;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(disapper:) userInfo:nil repeats:NO];
    }
    
}

-(void)disapper:(id)sender{
    errorUserView.hidden = YES;
    [sender invalidate];
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,20)];
    
    view.backgroundColor=[UIColor clearColor];
    
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height;
    height = 10;
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

-(void)testBack{
    [ self dismissViewControllerAnimated: YES completion: nil ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"savecell";
    
    SaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[SaveTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID indexPath:indexPath];
    }
       return cell;
}
// 隐藏多余cell

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
