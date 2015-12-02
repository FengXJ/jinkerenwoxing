//
//  InformationController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/22.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "InformationController.h"
#import "WeiboSDK.h"
#import "Yidenglu.h"
#import "AppDelegate.h"
#import "Userzhanghu.h"
#import "AFNetworking.h"

@interface InformationController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSArray *columns;
    NSMutableArray *userinformation;
    AppDelegate *app;
    AFHTTPRequestOperationManager * mananger;
    UIImagePickerController * imagePiker;
    Userzhanghu *yonghu;
    int ChooseBtn;//用于判断是换头像还是换背景
   
}
@property (strong, nonatomic) IBOutlet UITableView *contentTableView;
@property (strong, nonatomic) IBOutlet UIButton *touXiangbtn;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *qianming;
@property (strong, nonatomic) IBOutlet UIImageView *beijingtupian;
//存放所有的实体数据
@property (nonatomic,strong) NSMutableArray *Users;


@end

@implementation InformationController

- (void)viewDidLoad {
    [super viewDidLoad];

    app = [UIApplication sharedApplication].delegate;
    yonghu = nil;
    if (self.chaKan == nil) {
        yonghu = [app returnzhanghu];
    }else{
        yonghu = [app chaXunUserInformationBy:self.chaKan];
    }
    //初始化UI
    [self uiInit];
    //初始化一下
    imagePiker = [[UIImagePickerController alloc] init];
    //设置委托
    imagePiker.delegate = self;
    imagePiker.allowsEditing = YES;

}
//编辑个人资料
- (IBAction)bianjigerenziliao:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)zhuxiaoyonghu:(UIButton *)sender {
    
   
    BOOL flag = [app boolweiboshouquan];
    if (flag == YES) {
        mananger = [AFHTTPRequestOperationManager manager];
        mananger.responseSerializer = [AFJSONResponseSerializer serializer];
        mananger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
        //查找数据 创建实体对象
        NSEntityDescription * entity = [NSEntityDescription entityForName:@"WeiboSDK" inManagedObjectContext:app.managedObjectContext];
        
        //创建抓取数据的对象
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
        NSError *error = nil;
        NSArray* array = [ app.managedObjectContext executeFetchRequest:request error:&error];
        WeiboSDK *info = [array objectAtIndex:0];
        NSString *lingpai =  info.access_token;
       
        // 4. 输出结果
        for (info in array) {
            
            // 删除一条记录
            [app.managedObjectContext deleteObject:info];
            break;
        }
        // 5. 通知_context保存数据
        if ([app.managedObjectContext save:nil]) {
            NSLog(@"删除成功哦");
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            
            [dic setValue:lingpai forKey:@"access_token"];
            [mananger GET:@"https://api.weibo.com/oauth2/revokeoauth2" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                BOOL nicheng = [responseObject valueForKey:@"result"];
                if (nicheng == YES) {
                    
                    [self alert:@"确定要注销账户吗？"];
                }
                else {
                    NSLog(@"微博取消授权失败");
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        } else {
            NSLog(@"删除失败");
            }
    }
    else{
        [self alert:@"确定要注销账户吗？"];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{

    [self viewDidLoad];
    [self.contentTableView reloadData];
    animated = YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    UILabel *shuxing=(UILabel *)[cell viewWithTag:1];
    UILabel *value=(UILabel *)[cell viewWithTag:2];
    Userzhanghu *user = nil;
    user = [app returnzhanghu];
    
    switch (indexPath.row) {
        case 0:
            shuxing.text = @"性别";
            value.text = user.sex;
            
            break;
        case 1:
            shuxing.text = @"年龄";
            value.text = user.nianling;
            
            break;
        case 2:
            shuxing.text = @"学院";
            value.text = user.xueyuan;
            
            break;
            
        default:
            break;
    }
  
    
    return cell;
}
-(void)alert:(NSString*)message{
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.view.window.rootViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:SureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
//名字错了 这个是改背景
- (IBAction)changetouxiang:(UIButton *)sender {
    ChooseBtn = 1;
    [self ImageChooseAlert];
}
//这个是改头像
- (IBAction)changeTouXiang:(UIButton *)sender {
    ChooseBtn = 2;
    [self ImageChooseAlert];
}

-(void)ImageChooseAlert{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        [self openCarame];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        [self openImage];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
}
-(void)openCarame{
    //先判断是否可以使用摄像头
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        
        //type要修改成Camera类型
        imagePiker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //设置相机捕获的模式
        imagePiker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        
        //选择默认使用 前置后置的 摄像头
        imagePiker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        
        imagePiker.allowsEditing = YES;
        
        //弹出已经修改成相机类型的 Image Picker
        [self presentViewController:imagePiker animated:YES completion:^(){
            
        }];
    }else{
        NSLog(@"设备不支持摄像头");
    }
}
-(void)openImage{
    //先判断可以使用照片库
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary ] ) {
        //设置image picker的类型为浏览照片库
        imagePiker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        //用自己controller方法弹出一个ImagePickerController
        [self presentViewController:imagePiker animated:YES completion:^(void){
            
        }];
    }else{
        NSLog(@"打开相册失败");
    }
}
//实现委托
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //委托给当前 我们自己控制逻辑 处理要不要消失，如果选择不符合，我们添加if逻辑让他不消失
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker   didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    //image 就是修改后的照片
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *ImageName = [[NSString alloc]init];
    if (ChooseBtn == 1) {
        ImageName = [NSString stringWithFormat:@"UserBeiJing%@.png",yonghu.name];
    }else{
        ImageName = [NSString stringWithFormat:@"UserTouXiang%@.png",yonghu.name];
    }
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:ImageName];   // 保存文件的名称
    [UIImagePNGRepresentation(image)writeToFile: filePath    atomically:YES];
    NSError *error = nil;
    if ([app.managedObjectContext save:&error] ) {
        NSLog(@"保存成功");
    }
    else {
        NSLog(@"添加youxiangpath对象到coredata出错 %@",error);
    }
    //结束操作
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)uiInit{
    self.username.text = yonghu.nicheng;
    self.qianming.text = yonghu.xinqing;
    self.beijingtupian.userInteractionEnabled=YES;
    //圆形
    UIImageView *touXiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
    touXiangImageView.backgroundColor = [UIColor redColor];
    touXiangImageView.layer.cornerRadius = touXiangImageView.frame.size.width / 2;
    touXiangImageView.clipsToBounds = YES;
    [self.touXiangbtn addSubview:touXiangImageView];
    
    NSArray *BGpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *BGfilePath = [[BGpaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"UserBeiJing%@.png",yonghu.name]];   // 保存文件的名称
    UIImage *BGimg = BGimg = [UIImage imageWithContentsOfFile:BGfilePath];
    if (BGimg == nil) {
        BGimg = [UIImage imageNamed:@"usermorenbeijing"];
    }
    self.beijingtupian.image = BGimg;

    NSArray *touXiangpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *touXiangfilePath = [[touXiangpaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"UserTouXiang%@.png",yonghu.name]];   // 保存文件的名称
    UIImage *touXiangimg = [UIImage imageWithContentsOfFile:touXiangfilePath];
    if (touXiangimg == nil) {
        touXiangimg = [UIImage imageNamed:@"usermorenbeijing"];
    }
    touXiangImageView.image = touXiangimg;
 
}

@end
