//
//  NewFeatureController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/9/13.
//  Copyright (c) 2015年 冯学杰. All rights reserved.
//

#import "NewFeatureController.h"
#import "LoginController.h"
#define  PicCount 3
@interface NewFeatureController (){
    UIWindow *window;
}

@end

@implementation NewFeatureController
-(instancetype)init{
    self = [super init];
    if (self) {
    //初始化分页和scrollView控件
        
    _scrollV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    CGFloat scrollW = _scrollV.width;
    CGFloat scrollH = _scrollV.height;
    //往scrollView里面添加图片
    for (int i = 0; i<PicCount; i++) {
        _ImageV = [[UIImageView alloc]init];
        _ImageV.width = scrollW;
        _ImageV.height = scrollH;
        _ImageV.x = i*scrollW;
        _ImageV.y = 0;
        //获取新特性图片
        _ImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"NewFeature-%d",(i)]];
        
        if (i==(PicCount-1)) {
            [self setUpdate:_ImageV];
        }
        [_scrollV addSubview:_ImageV];
    }
   //设置scrollView里面可以滚动的范围，如果在哪个方向不能滚动，设置为0
    _scrollV.contentSize = CGSizeMake(PicCount*scrollW, 0);
    //去掉弹簧效果
    _scrollV.bounces = NO;
    //图片移动到一半，自动分页
    _scrollV.pagingEnabled = YES;
    _scrollV.delegate = self;
    [self.view addSubview:_PageControl];
    }
    return self;
}
-(void)setUpdate:(UIImageView*)imageView{
    UIButton *starBtn = [[UIButton alloc]init];
    starBtn.frame=CGRectMake(SCREEN_WIDTH-180, SCREEN_HEIGHT-220, 50, 30);
    [starBtn setTitle:@"进入" forState:UIControlStateNormal];
    [starBtn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    imageView.userInteractionEnabled = YES;
    [imageView addSubview:starBtn];
    
}
-(void)enter
{
    window = [UIApplication sharedApplication].keyWindow;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginController *viewCtl = [storyBoard instantiateViewControllerWithIdentifier:@"LoginController"];
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //        self.window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = viewCtl;
    [window makeKeyAndVisible];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // NSLog(@"%lf",_scrollView.contentOffset.x);
    //设置分页控件的页码
    double page = (_scrollV.contentOffset.x +
                   _scrollV.width-0.01)/_scrollV.width;
    _PageControl.currentPage = (int)page;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _scrollV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    CGFloat scrollW = _scrollV.width;
    CGFloat scrollH = _scrollV.height;
    //往scrollView里面添加图片
    for (int i = 0; i<PicCount; i++) {
        _ImageV = [[UIImageView alloc]init];
        _ImageV.width = scrollW;
        _ImageV.height = scrollH;
        _ImageV.x = i*scrollW;
        _ImageV.y = 0;
        //获取新特性图片
        _ImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"NewFeature-%d",(i)]];
        
        if (i==(PicCount-1)) {
            [self setUpdate:_ImageV];
        }
        [_scrollV addSubview:_ImageV];
    }
    //设置scrollView里面可以滚动的范围，如果在哪个方向不能滚动，设置为0
    _scrollV.contentSize = CGSizeMake(PicCount*scrollW, 0);
    //去掉弹簧效果
    _scrollV.bounces = NO;
    //图片移动到一半，自动分页
    _scrollV.pagingEnabled = YES;
    
    _scrollV.delegate = self;
    [self.view addSubview:_PageControl];
     NSLog(@"%lf,%lf",SCREEN_HEIGHT,SCREEN_WIDTH);
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
