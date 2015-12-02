//
//  WeiboSDK+CoreDataProperties.h
//  我的项目1.2
//
//  Created by 冯学杰 on 15/11/5.
//  Copyright © 2015年 冯学杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WeiboSDK.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeiboSDK (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *uid;
@property (nullable, nonatomic, retain) NSString *remind_in;
@property (nullable, nonatomic, retain) NSDate *recordTime;
@property (nullable, nonatomic, retain) NSNumber *expires_in;
@property (nullable, nonatomic, retain) NSString *access_token;

@end

NS_ASSUME_NONNULL_END
