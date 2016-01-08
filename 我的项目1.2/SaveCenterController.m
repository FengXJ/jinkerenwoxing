//
//  SaveCenterController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 16/1/6.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "SaveCenterController.h"

@interface SaveCenterController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *bodyTableview;

@property (nonatomic,strong) UIButton *sureBtn;

@end

@implementation SaveCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *BGimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20+44, SCREEN_WIDTH, SCREEN_HEIGHT)];
    BGimageView.image = [UIImage imageNamed:@"NewFeature-1"];
    [self.view addSubview:BGimageView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    headView.backgroundColor =[UIColor grayColor];
    [self.view addSubview:headView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    titleLabel.text = @"修改密码";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 44)];
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
    
}

-(void)sure:(id)sender{
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 16.5, 100, 15)];
    [cell.contentView addSubview:titleLabel];
    titleLabel.font = [LCFont systemFontOfSize:15];
    
    UITextField *contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.x+titleLabel.width, 8, SCREEN_WIDTH-15-titleLabel.x-titleLabel.width, 30)];
    contentTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [cell.contentView addSubview:contentTextField];
    
    UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.x+titleLabel.width, 8, SCREEN_WIDTH-15-titleLabel.x-titleLabel.width, 30)];
    saveLabel.hidden = YES;
    saveLabel.text = @"您第一次乘坐火车的目的地";
    [cell.contentView addSubview:saveLabel];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            titleLabel.text = @"安全问题";
            contentTextField.hidden = YES;
            saveLabel.hidden = NO;
            
        }
        if (indexPath.row == 1) {
            titleLabel.text = @"请输入答案";
            contentTextField.placeholder = @"请输入答案";
            saveLabel.hidden = YES;
            contentTextField.hidden = NO;
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            titleLabel.text = @"请输入新密码";
            contentTextField.placeholder = @"请输入新密码";
        }
        if (indexPath.row == 1) {
            titleLabel.text = @"再输入新密码";
            contentTextField.placeholder = @"再输入新密码";
        }
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

@end
