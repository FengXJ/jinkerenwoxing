//
//  FriendController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/22.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "FriendController.h"
#import "EaseMob.h"

@interface FriendController ()<UITableViewDataSource,UITableViewDelegate,IChatManagerDelegate>{
    NSArray *friendList;
}
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation FriendController


- (void)viewDidLoad {
    [super viewDidLoad];
//    //获取好友列表    1
//    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
//        if (!error) {
//            NSLog(@"获取成功 -- %@",buddyList);
//            friendList = buddyList;
//            [self.listTableView reloadData];
//        }
//    } onQueue:nil];
    EMError *error = nil;
    NSArray *buddyList = [[EaseMob sharedInstance].chatManager fetchBuddyListWithError:&error];
    if (!error) {
        NSLog(@"获取成功 -- %@",buddyList);
        friendList = buddyList;
        
    }

}

-(void)setUi{
    //隐藏底部空白cell
    UIView *footv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    footv.backgroundColor = [UIColor whiteColor];
    [self.listTableView setTableFooterView:footv];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (friendList!= nil) {
        return friendList.count;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell内存优化
    static NSString *cellID=@"friend";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        //        cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    }
    UILabel *friendNameLabel =(UILabel *)[cell viewWithTag:2];
    UILabel *chatLabel =(UILabel *)[cell viewWithTag:3];
    UIButton *touXiangBtn =(UIButton *)[cell viewWithTag:1];
    
    //头像Image
    UIImageView *touxiang = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 35, 35)];
    touxiang.layer.cornerRadius = touxiang.frame.size.width / 2;
    touxiang.clipsToBounds = YES;
    
//    NSArray *touXiangpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *touXiangfilePath = [[touXiangpaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"UserTouXiang%@.png",[dongtais valueForKey:@"fatierenname"]]];   // 保存文件的名称
//    UIImage *touXiangimg = [UIImage imageWithContentsOfFile:touXiangfilePath];
//    if (touXiangimg == nil) {
//        touXiangimg = [UIImage imageNamed:@"usermorenbeijing"];
//    }
//    touxiang.image = touXiangimg;
    
    [touXiangBtn addSubview:touxiang];
    if (friendList !=nil) {
        
        EMBuddy * str = [friendList objectAtIndex:indexPath.row];
        friendNameLabel.text = str.username;

    }
//
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
