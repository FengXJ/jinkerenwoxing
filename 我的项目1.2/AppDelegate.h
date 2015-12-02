//
//  AppDelegate.h
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/13.
//  Copyright (c) 2015年 冯学杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Userzhanghu.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//返回已登录用户名
-(NSString *)chaxunyidengluyonghuming;
//返回账户信息
-(Userzhanghu *)returnzhanghu;
//判断微博是否授权了
-(BOOL)boolweiboshouquan;
//根据用户名查用户资料
-(Userzhanghu *)chaXunUserInformationBy:(NSString *)name;
//判断是否有这个用户
-(BOOL)isUser:(NSString*)string;
@end

