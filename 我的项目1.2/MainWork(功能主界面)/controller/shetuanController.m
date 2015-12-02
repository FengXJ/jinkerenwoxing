//
//  shetuanController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/10/22.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "shetuanController.h"

@interface shetuanController (){
    NSString *xuhao;

    NSString *xuanzedemokuai;//点击的按钮是哪个模块 传递到下一视图 决定视图显示内容
}

@property (nonatomic,strong) NSArray *shetuan;

@property(copy,nonatomic)NSString *mokuaiming;
@property (nonatomic,strong) NSDictionary *shetuans;

@end

@implementation shetuanController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //标题
    self.navigationItem.title = @"社团联盟";
    //加载plist文件信息
    NSBundle *mainBundle = [NSBundle mainBundle];
    self.shetuans = [NSDictionary dictionaryWithContentsOfFile:[mainBundle pathForResource:@"shetuan" ofType:@"plist"]];
    
    self.shetuan = [self.shetuans allKeys];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.shetuans.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 

    
    static NSString *cellID =@"shetuancell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//        cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    }
//
    //获取cell控件
    UILabel *title=(UILabel *)[cell viewWithTag:2];
    UILabel *jianjie=(UILabel *)[cell viewWithTag:3];

    
    //读取字典
    NSString *shetuanmingzi = self.shetuan[indexPath.row];
    NSArray *allcity = self.shetuans[shetuanmingzi];
    jianjie.text = [allcity valueForKey:@"jianjie"];
    xuhao = [allcity valueForKey:@"xuhao"];

    title.text=shetuanmingzi;
    cell.imageView.image= [UIImage imageNamed:[NSString stringWithFormat:@"shetuan-%@",xuhao]];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //获取indexpath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    //查找当前点击的序号
    NSString *shetuanmingzi = [NSString stringWithFormat:@"1%ld",indexPath.row];
    //传递
    UIViewController *vc=segue.destinationViewController;
    [vc setValue:shetuanmingzi forKey:@"mokuaiming"];
//    NSLog(@"%@",shetuanmingzi);
}


@end
