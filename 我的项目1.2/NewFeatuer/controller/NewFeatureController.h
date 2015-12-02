//
//  NewFeatureController.h
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/13.
//  Copyright (c) 2015年 冯学杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@interface NewFeatureController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollV;
@property (strong, nonatomic) IBOutlet UIPageControl *PageControl;
@property (strong, nonatomic) IBOutlet UIImageView *ImageV;

@end
