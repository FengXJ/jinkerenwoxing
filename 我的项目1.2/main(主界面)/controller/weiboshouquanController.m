//
//  weiboshouquanController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/11/4.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "weiboshouquanController.h"
#import "AFNetworking.h"
#import "weibocanshu.h"
#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "Weibouser.h"
#import "Yidenglu.h"
#import "Userzhanghu.h"
@interface weiboshouquanController (){
    //请求JSON数据的网络框架
    AFHTTPRequestOperationManager * mananger;
    AppDelegate *app;
    WeiboSDK * info;//存model参数
    
    BOOL flag1;
}
@property(nonatomic,strong) Userzhanghu *zhanghus;
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UINavigationItem *navitem;

@end

@implementation weiboshouquanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     app = [UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view.
    //https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@
    //https://api.weibo.com/oauth2/authorize
    //https://api.weibo.com/oauth2/authorize?client_id=4256483203&redirect_uri=http://www.baidu.com
    //    self.athoWebView.delegate = self;
    mananger = [AFHTTPRequestOperationManager manager];
    mananger.responseSerializer = [AFJSONResponseSerializer serializer];
    mananger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
    
    NSString * oauth2String = IWB_AUTHORIZE_URL;
    
    NSURL * url = [NSURL URLWithString:oauth2String];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
   
    
//    [request NSURLRequestReloadIgnoringLocalCacheData];
    
//    [[NSURLRequestReloadIgnoringLocalCacheData sharedHTTPCookieStorage] setCookies:nil
//                                                       forURL:request.URL
//                                              mainDocumentURL:nil];
    
    self.webview.delegate = self;
    [self.webview loadRequest:request];
    
    

    [self leftitem];
}
//左边的titem
-(void)leftitem{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0,0,50,25);
    addButton.bounds = frame;
    [addButton setTitle:@"返回" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton addTarget:self action:@selector(chaa) forControlEvents:UIControlEventTouchUpInside];
     self.navitem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
}
//返回
-(void)chaa{
    [self performSegueWithIdentifier:@"login" sender:self];
    
}
#pragma mark webview每次加载之前都会调用这个方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * urlString = request.URL.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    //清理webviewcookies
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* baiduCookies = [cookies cookiesForURL:[NSURL URLWithString:urlString]];
    for (NSHTTPCookie* cookie in baiduCookies) {
        [cookies deleteCookie:cookie];
    }
    
    if  (range.length) {
        //获取到授权的code
        NSString * oauthCode = [urlString substringFromIndex: range.location+range.length];
        [self accessOauthWithCode:oauthCode];
        return NO;
    }
    return YES;
}
- (void) accessOauthWithCode:(NSString*)oCode {
//    用于接受参数值
     NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:IWB_APP_ID forKey:IWB_KET_APP_ID];
    [dic setValue:IWB_APP_SECERT forKey:@"client_secret"];
    [dic setValue:@"authorization_code" forKey:@"grant_type"];
    [dic setValue:oCode forKey:@"code"];
    [dic setValue:IWB_REDIRECT_URI forKey:@"redirect_uri"];
    //先获取令牌
    [mananger POST:IWB_TOKEN_URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = nil;
        NSArray * array = nil;
        if ( [responseObject isKindOfClass: [NSArray class] ] ) {

        }
        else if ( [responseObject isKindOfClass: [NSDictionary class] ] ) {
            dic = responseObject;
        }
        else {
            //异常处理
        }
        
//
        //查找数据 创建实体对象
        NSEntityDescription * entity = [NSEntityDescription entityForName:@"WeiboSDK" inManagedObjectContext:app.managedObjectContext];
        
        //创建抓取数据的对象
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];

        NSError *error = nil;
        array = [ app.managedObjectContext executeFetchRequest:request error:&error];
        
        NSError *error2 = nil;
        
        info= nil;
            //插入一条新数据
        info = [NSEntityDescription insertNewObjectForEntityForName:@"WeiboSDK" inManagedObjectContext: app.managedObjectContext];
        
        info.access_token= [dic valueForKey:@"access_token"];
        info.expires_in= [dic valueForKey:@"expires_in"];
        info.uid= [dic valueForKey:@"uid"];
        info.recordTime = [NSDate date];
    
        
        error2 = nil;
        
        if ( [app.managedObjectContext save:&error2] ) {
            
           
            // 请求微博授权码
            NSMutableDictionary * dic2 = [NSMutableDictionary dictionary];
            [dic2 setValue:info.access_token forKey:@"access_token"];
            [dic2 setValue:info.uid forKey:@"uid"];
            [dic2 setValue:IWB_APP_ID forKey:@"source"];
            
            [mananger GET:@"https://api.weibo.com/2/users/show.json" parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {

                //得到用户昵称
                NSString *name = [NSString stringWithFormat:@"%@",info.uid];
                NSString *nicheng = [responseObject valueForKey:@"screen_name"];
                [self weibotozhuce:name withnicheng:nicheng];
                //将昵称放入已登录表
                [self nichengtoyidenglubiao:name];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];

            //密码正确并保存  进入主界面
            UIStoryboard * stroyboard= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * homePageViewController = [stroyboard instantiateViewControllerWithIdentifier:@"Maintab"];
            [self presentViewController:homePageViewController animated:YES completion:^{
                
            }];
        }
        else {
            NSLog(@"error %@",error2);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//相当注册
-(void)weibotozhuce:(NSString *)name withnicheng:(NSString *)nicheng{
    //模型实体
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
    //创建抓取数据的对象
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    //判断用户名是否重复
    [request setPredicate: [NSPredicate predicateWithFormat:@"name=%@",name]];
    NSError *error2 = nil;
    NSArray *result = [app.managedObjectContext executeFetchRequest:request error:&error2];
    
    if (result.count!=0) {
        
    }
    else{
        
            //使用 实体对象 相当于sqlite的增加
            Userzhanghu *zhanghu = nil;
            //判断是否需要修改 如果是修改 把实体对象赋值给book 进行修改
            if (self.zhanghus) {
                zhanghu= self.zhanghus;
            }
            else {
                zhanghu = [NSEntityDescription insertNewObjectForEntityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
                
            }
            
            //当普通的对象使用
            zhanghu.name = name;
            zhanghu.pwd = nil;
            zhanghu.save = nil;
            zhanghu.nicheng = nicheng;
            zhanghu.xinqing = @"心情美不美，写下来吧！";
            
            
            //定义
            NSError * error = nil;
            //保存coredata的数据
            if ([app.managedObjectContext save:&error] ) {
                
                
            }
            else {
                NSLog(@"添加Books对象到coredata出错 %@",error);
            }
        
    }
}
//放进已登录表
-(void)nichengtoyidenglubiao:(NSString*)name{
    //查询已登录表有没有信息
    NSEntityDescription * entityyidenglu = [NSEntityDescription entityForName:@"Yidenglu" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest * request2 = [[NSFetchRequest alloc] init];
    [request2 setEntity:entityyidenglu];
    
    [request2 setPredicate:[NSPredicate predicateWithFormat:@"name!=nil"]];
    NSError *error2 = nil;
    NSArray *result2 = [app.managedObjectContext executeFetchRequest:request2 error:&error2];
    
    if (result2.count!=0) {
        //             1. 实例化查询请求
        
        
        // 4. 输出结果
        for (Yidenglu *yidenglu in result2) {
            
            
            // 删除一条记录
            [app.managedObjectContext deleteObject:yidenglu];
            break;
        }
        
        // 5. 通知_context保存数据
        if ([app.managedObjectContext save:nil]) {
            
            NSLog(@"删除成功");
        } else {
            
            NSLog(@"删除失败");
            
        }
    }else{
    }
    Yidenglu *yidenglu = nil;
    yidenglu = [NSEntityDescription insertNewObjectForEntityForName:@"Yidenglu" inManagedObjectContext:app.managedObjectContext];
    NSError * error = nil;
    yidenglu.name = name;
    //保存coredata的数据
    if ([app.managedObjectContext save:&error] ) {

        
    }
    else {
        NSLog(@"添加Books对象到coredata出错 %@",error);
    }
    

}
//发送微博方法
-(BOOL)fasongweibo:(NSString*)fasongneirong{
    flag1 = YES;
    fasongneirong = [NSString stringWithFormat:@"%@                 ----------来自于金科任我行",fasongneirong];
    NSString *token =  [self dedaotoken];
    if (token == nil) {

        flag1 = NO;
    }else {
    //    用于接受参数值
    NSNumber *num = [NSNumber numberWithInt:0];
    NSMutableDictionary * weibodic = [[NSMutableDictionary alloc] init];
    [weibodic setValue:IWB_APP_ID forKey:@"source"];
    [weibodic setValue:token forKey:@"access_token"];
    [weibodic setValue:fasongneirong forKey:@"status"];
    [weibodic setValue:num forKey:@"visible"];
    
    mananger = [AFHTTPRequestOperationManager manager];
    mananger.responseSerializer = [AFJSONResponseSerializer serializer];
    mananger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",nil];
    
    [mananger POST:@"https://api.weibo.com/2/statuses/update.json" parameters:weibodic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSLog(@"发送成功");
        [self alert:@"分享成功"];
        flag1 = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送失败%@",error);
        [self alert:@"分享失败"];
        flag1 = NO;
    }];
 
    }
    return flag1;
}
-(NSString *)dedaotoken{
    NSString *token = nil;
    NSArray *result = nil;
    app= [ UIApplication sharedApplication].delegate;
    //查找数据 创建实体对象
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"WeiboSDK" inManagedObjectContext:app.managedObjectContext];
    //创建抓取数据的对象
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    
    [request setPredicate: [NSPredicate predicateWithFormat:@"uid != nil"]];
    NSError *error = nil;
    result = [app.managedObjectContext executeFetchRequest:request error:&error];
    
    if (result.count == 0) {
        token = nil;
    }
    else {
        WeiboSDK *weibosdk = nil;
        weibosdk = [result objectAtIndex:0];
        token = weibosdk.access_token;
    }
    return token;
}

-(void)alert:(NSString*)message{
    UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *SureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [successAlert addAction:SureAction];
    [self presentViewController:successAlert animated:YES completion:nil];
}

@end
