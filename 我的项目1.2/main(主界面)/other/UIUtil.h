//
//  UIUtil.h
//  test4
//
//  Created by 冯学杰 on 15/12/1.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtil : NSObject
//颜色

#define LCRGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define LCRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define LCHexColor(a) [UIColor colorWithRed:(a>>16)/255.0 green:(a>>8&0xff)/255.0 blue:(a&0xff)/255.0 alpha:1]
#define LCHexAColor(c,a) [UIColor colorWithRed:(c>>16)/255.0 green:(c>>8&0xff)/255.0 blue:(c&0xff)/255.0 alpha:a]

//统一线的颜色
#define LINECOLOR           LCRGBColor(227, 227, 227)
#define LineColor(a) [UIColor colorWithRed:(a>>16)/255.0 green:(a>>8&0xff)/255.0 blue:(a&0xff)/255.0 alpha:1]

//屏幕相关
#define  SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

//系统版本

#define IS_OS_6 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=6.0 && \
[[[UIDevice currentDevice] systemVersion] doubleValue]<7.0)

#define IS_OS_7 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0 && \
[[[UIDevice currentDevice] systemVersion] doubleValue]<8.0)

#define IS_OS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define IS_OS_7_Later ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)

#define IS_INCH_3_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_INCH_4   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_INCH_4_7  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_INCH_5_5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

@end
