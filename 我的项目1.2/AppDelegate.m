//
//  AppDelegate.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/13.
//  Copyright (c) 2015年 冯学杰. All rights reserved.
//

#import "AppDelegate.h"
#import "NewFeatureController.h"
#import "LoginController.h"
#import "Yidenglu.h"
#import "WeiboSDK.h"
#import "EaseMob.h"


@interface AppDelegate (){
    AppDelegate *app;
    Yidenglu *yonghu;
    Userzhanghu *user;
}

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //registerSDKWithAppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"578719825#578719825" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [self switchController];

   
    
    return YES;
}
-(void)switchController{
//    NSString *key =@"CFBundleVersion";
//    //获取当前软件版本号
//    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
//    NSString *currentVersion = dict[key];
//    //根据用户偏好设置获取以前存储的值
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    if ([currentVersion isEqualToString:lastVersion]) {
//        BOOL flag = [self boolweiboshouquan];
//        if (flag == YES) {
//            UIStoryboard * stroyboard= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UITabBarController * homePageViewController = [stroyboard instantiateViewControllerWithIdentifier:@"Maintab"];
//            self.window.rootViewController = homePageViewController;
//        }else{
//            UIStoryboard * stroyboard= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UIViewController * homePageViewController = [stroyboard instantiateViewControllerWithIdentifier:@"LoginController"];
//            self.window.rootViewController = homePageViewController;
//        }
// 
//    }else{ //把当前软件最新版本写进沙盒的用户偏好设置里面
        NewFeatureController *newController = [[NewFeatureController alloc]init];
        self.window.rootViewController = newController;
//        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//    }
    
}
-(NSString *)chaxunyidengluyonghuming{
    app = [UIApplication sharedApplication].delegate;
    //查询已登录表有没有信息
    NSEntityDescription * entityyidenglu = [NSEntityDescription entityForName:@"Yidenglu" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entityyidenglu];
    
    [request1 setPredicate:[NSPredicate predicateWithFormat:@"name!=nil"]];
    NSError *error = nil;
    NSArray *result = [app.managedObjectContext executeFetchRequest:request1 error:&error];
    yonghu =nil;
    //获取已登录名
    yonghu = [result objectAtIndex:0];
    NSString *yingdengluyonghu = yonghu.name;
    return yingdengluyonghu;
//    NSLog(@"%@",yingdengluyonghu);
//    //根据以登录名获取用户信息
//    NSEntityDescription * yonghuxinxi = [NSEntityDescription entityForName:model inManagedObjectContext:app.managedObjectContext];
//    NSFetchRequest * request2 = [[NSFetchRequest alloc] init];
//    [request2 setEntity:yonghuxinxi];
//    
//    [request2 setPredicate:[NSPredicate predicateWithFormat:@"name=%@",yingdengluyonghu]];
//    NSError *error2 = nil;
//    NSArray *result2 = [app.managedObjectContext executeFetchRequest:request2 error:&error2];
//    
//    //根据查询到的信息显示名字和昵称
//    Userzhanghu *yonghu2 = nil;
//    yonghu2 = [result2 objectAtIndex:0];
}
//-(NSString *)returnnicheng{
//    NSString *yidengluyonghu = [self chaxunyidengluyonghuming];
//    app = [UIApplication sharedApplication].delegate;
//    //查询已登录表有没有信息
//    NSEntityDescription * entityyidenglu = [NSEntityDescription entityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
//    NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
//    [request1 setEntity:entityyidenglu];
//    
//    [request1 setPredicate:[NSPredicate predicateWithFormat:@"name=%@",yidengluyonghu]];
//    NSError *error = nil;
//    NSArray *result = [app.managedObjectContext executeFetchRequest:request1 error:&error];
//    user =nil;
//    //获取已登录名
//    user = [result objectAtIndex:0];
//    NSString *nicheng = user.nicheng;
//    return nicheng;
//}
-(Userzhanghu *)returnzhanghu{
    NSString *yidengluyonghu = [self chaxunyidengluyonghuming];
    app = [UIApplication sharedApplication].delegate;
    //查询已登录表有没有信息
    NSEntityDescription * entityyidenglu = [NSEntityDescription entityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entityyidenglu];
    
    [request1 setPredicate:[NSPredicate predicateWithFormat:@"name=%@",yidengluyonghu]];
    NSError *error = nil;
    NSArray *result = [app.managedObjectContext executeFetchRequest:request1 error:&error];
    Userzhanghu *user1= nil;
   
    //获取用户信息
    user1 = [result objectAtIndex:0];
    
    return user1;
}
// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "-.____1_2" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"____1_2" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"____1_2.sqlite"];
    //打印sqlite位置
    NSLog(@"%@",storeURL);
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.3333333333333333333
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
//判断微博是否授权了
-(BOOL)boolweiboshouquan{
    BOOL flag;
        AppDelegate * app1 = [UIApplication sharedApplication].delegate;
    
       NSEntityDescription * entity = [NSEntityDescription entityForName:@"WeiboSDK" inManagedObjectContext:app1.managedObjectContext];
       // 创建抓取数据的请求对象
       NSFetchRequest * request = [[NSFetchRequest alloc] init];
       [request setEntity:entity];

       NSError *error = nil;
       NSArray * array = [app1.managedObjectContext executeFetchRequest:request error:&error];
    
    
    if (array.count!=0) {
        //有授权直接跳入主界面
         WeiboSDK* atuh = [array objectAtIndex:0];
        //判断令牌有没有过期
        NSDate * expiresDate = atuh.recordTime;
        expiresDate = [expiresDate dateByAddingTimeInterval: [atuh.expires_in integerValue]];
        
        if ([expiresDate compare: [NSDate date] ] == NSOrderedAscending) {
            //过期
            NSLog(@"时间过期");

            flag = NO;
        }
        else {
            //没过期
          
            flag = YES;
        }
    }
    else {
        //没有授权进入正常登录界面
     
        flag = NO;
        
    }
    return flag;

}
-(Userzhanghu *)chaXunUserInformationBy:(NSString *)name{
 
    app = [UIApplication sharedApplication].delegate;
    
    NSEntityDescription * entityyidenglu = [NSEntityDescription entityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entityyidenglu];
    
    [request1 setPredicate:[NSPredicate predicateWithFormat:@"name=%@",name]];
    NSError *error = nil;
    NSArray *result = [app.managedObjectContext executeFetchRequest:request1 error:&error];
    Userzhanghu *user1= nil;
    
    //获取用户信息
    user1 = [result objectAtIndex:0];
    
    return user1;

}
-(BOOL)isUser:(NSString*)string{
    app = [UIApplication sharedApplication].delegate;
    
    NSEntityDescription * entityyidenglu = [NSEntityDescription entityForName:@"Userzhanghu" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entityyidenglu];
    
    [request1 setPredicate:[NSPredicate predicateWithFormat:@"name=%@",string]];
    NSError *error = nil;
    NSArray *result = [app.managedObjectContext executeFetchRequest:request1 error:&error];
    BOOL flag;
    if (result.count != 0) {
        flag = YES;
    }else{
        flag = NO;
    }
    return flag;
}

@end
