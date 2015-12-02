//
//  Dongtaizan+CoreDataProperties.h
//  我的项目1.2
//
//  Created by 冯学杰 on 15/11/7.
//  Copyright © 2015年 冯学杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Dongtaizan.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dongtaizan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *dongtaiID;
@property (nullable, nonatomic, retain) NSString *dianzanren;
@property (nullable, nonatomic, retain) NSString *shifoudianzan;

@end

NS_ASSUME_NONNULL_END
