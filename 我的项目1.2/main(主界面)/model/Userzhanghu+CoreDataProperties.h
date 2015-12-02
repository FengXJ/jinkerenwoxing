//
//  Userzhanghu+CoreDataProperties.h
//  我的项目1.2
//
//  Created by 冯学杰 on 15/11/25.
//  Copyright © 2015年 冯学杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Userzhanghu.h"

NS_ASSUME_NONNULL_BEGIN

@interface Userzhanghu (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *nianling;
@property (nullable, nonatomic, retain) NSString *nicheng;
@property (nullable, nonatomic, retain) NSString *pwd;
@property (nullable, nonatomic, retain) NSString *save;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) NSString *xinqing;
@property (nullable, nonatomic, retain) NSString *xueyuan;
@property (nullable, nonatomic, retain) NSString *touxiangpath;

@end

NS_ASSUME_NONNULL_END
