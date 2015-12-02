//
//  weibocanshu.h
//  我的项目1.2
//
//  Created by 冯学杰 on 15/11/4.
//  Copyright © 2015年 冯学杰. All rights reserved.
//
//定义固定参数

#import <Foundation/Foundation.h>

#define IWB_APP_ID  @"2352851729"
#define IWB_REDIRECT_URI  @"http://www.baidu.com"
#define IWB_APP_SECERT @"d85a7217f2e5670495e2fcea0850b4f9"

//定义接口URL（API）
#define IWB_AUTHORIZE_URL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",IWB_APP_ID,IWB_REDIRECT_URI]
#define IWB_TOKEN_URL @"https://api.weibo.com/oauth2/access_token"
#define IWB_FIRENDS_URL @"https://api.weibo.com/2/statuses/friends_timeline.json"
//key list
#define IWB_KET_APP_ID @"client_id"


@interface weibocanshu : NSObject

@end
