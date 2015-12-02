//
//  Dongtai+CoreDataProperties.h
//  我的项目1.2
//
//  Created by 冯学杰 on 15/11/26.
//  Copyright © 2015年 冯学杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Dongtai.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dongtai (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *dongtaiID;
@property (nullable, nonatomic, retain) NSString *dongtaineirong;
@property (nullable, nonatomic, retain) NSString *fabiaoren;
@property (nullable, nonatomic, retain) NSString *fabiaoshijian;
@property (nullable, nonatomic, retain) NSString *huifuren;
@property (nullable, nonatomic, retain) NSString *huifushijian;
@property (nullable, nonatomic, retain) NSString *yidu;
@property (nullable, nonatomic, retain) NSNumber *zan;
@property (nullable, nonatomic, retain) NSString *fatierenname;
@property (nullable, nonatomic, retain) NSString *fabiaorenId;

@end

NS_ASSUME_NONNULL_END
