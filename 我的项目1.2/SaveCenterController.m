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

@end

@implementation SaveCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 64)];
    backbtn.backgroundColor = [UIColor whiteColor];
    [backbtn setTitle:@"back" forState:UIControlStateNormal];
    [self.view addSubview:backbtn];
    [backbtn addTarget:self action:@selector(testBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *BGimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20+44, SCREEN_WIDTH, SCREEN_HEIGHT)];
    BGimageView.image = [UIImage imageNamed:@"NewFeature-1"];
    [self.view addSubview:BGimageView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    headView.backgroundColor =[UIColor grayColor];
    [self.view addSubview:headView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    titleLabel.text = @"修改密码";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    
    self.bodyTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) style:UITableViewStylePlain];
    self.bodyTableview.delegate = self;
    self.bodyTableview.dataSource = self;
    self.bodyTableview.backgroundColor = [UIColor clearColor];
    [BGimageView addSubview:self.bodyTableview];
    
    [self setExtraCellLineHidden:self.bodyTableview];
    
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
        return 1;
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
    cell.backgroundColor = LCHexColor(0xfafafa);
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 16.5, 200, 15)];
    [cell.contentView addSubview:titleLabel];
    titleLabel.font = [LCFont systemFontOfSize:15];
    
    UITextField *contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.x+titleLabel.width, 16.5, 200, 15)];
    [cell.contentView addSubview:contentTextField];
    
    if (indexPath.section == 0) {
        titleLabel.text = @"请输入旧密码";
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
