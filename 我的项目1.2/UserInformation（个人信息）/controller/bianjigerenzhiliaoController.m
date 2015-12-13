//
//  bianjigerenzhiliaoController.m
//  我的项目1.2
//
//  Created by 冯学杰 on 15/11/11.
//  Copyright © 2015年 冯学杰. All rights reserved.
//

#import "bianjigerenzhiliaoController.h"
#import "AppDelegate.h"


@interface bianjigerenzhiliaoController ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    AppDelegate *app;
    Userzhanghu *user ;
    NSString *xingbieStr;
    NSArray *xueyuans ;
    NSString *xueYuanSelect;
    UIPickerView *piker;
    UIButton *selectBtn;
}
@property (strong, nonatomic) IBOutlet UITextField *nicheng;
@property (strong, nonatomic) IBOutlet UISegmentedControl *xingbie;
@property (strong, nonatomic) IBOutlet UITextField *nianling;
@property (strong, nonatomic) IBOutlet UILabel *nameTiShi;


@property (strong, nonatomic) IBOutlet UIButton *xueyuan;

@property (strong, nonatomic) IBOutlet UITextView *xinqing;

@end

@implementation bianjigerenzhiliaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[mainBundle pathForResource:@"xueYuan" ofType:@"plist"]];
    xueyuans = [dic allKeys];
    app = [UIApplication sharedApplication].delegate;
    [self rigthitem];
    [self uiInit];

}

-(void)uiInit{
    user = nil;
    
    user = [app returnzhanghu];
    self.nicheng.text = user.nicheng;
    self.nianling.text = user.nianling;
    [self.xueyuan setTitle:user.xueyuan forState:UIControlStateNormal];
    self.xinqing.text = user.xinqing;
    
    
    self.nameTiShi.hidden = YES;
    xingbieStr = [[NSString alloc]init];
    xingbieStr = @"男";
    if ([user.sex isEqual:@"男"]) {
        self.xingbie.selectedSegmentIndex = 0;
    }else{
        self.xingbie.selectedSegmentIndex = 1;
    }
    
    [self.xueyuan addTarget:self action:@selector(chooseXueYuan) forControlEvents:UIControlEventTouchUpInside];
    
    piker = [[UIPickerView alloc]initWithFrame:CGRectMake(10, 150, 355, 200)];
    piker.dataSource=self;
    piker.delegate=self;
    piker.showsSelectionIndicator=YES;
    piker.backgroundColor = [UIColor grayColor];
    piker.alpha = .9;
    piker.hidden = YES;
    [self.view addSubview: piker];
    
    selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(300, 120, 50, 30)];
    selectBtn.hidden = YES;
    [selectBtn setTitle:@"确定" forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(sureXueYuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    
    
    
    [self.xueyuan.layer setBorderWidth:0.5];//设置边界的宽度
    //设置按钮的边界颜色
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){0.2,0.2,0.2,0.6});
    
    [self.xueyuan.layer setBorderColor:color];
    
    xueYuanSelect = [[NSString alloc]init];
    xueYuanSelect = xueyuans[0];
}

-(void)sureXueYuan{
    
    [UIView animateWithDuration:0.3 animations:^{
        piker.hidden = YES;
        selectBtn.hidden = YES;
        [self.xueyuan setTitle:xueYuanSelect forState:UIControlStateNormal];
    }];
}
-(void)chooseXueYuan{
    
    [UIView animateWithDuration:0.5 animations:^{
        piker.hidden = NO;
        selectBtn.hidden = NO;
    }];  
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    xueYuanSelect = xueyuans[row];
}
//一共多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  1;
}
//每列对应多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
 {
      //2.返回当前列对应的行数
     return xueyuans.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    
    NSString *str = xueyuans[row];
    return str;
}
//定义右边发帖按钮
-(void)rigthitem{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0,0,100,25);
    addButton.bounds = frame;
    [addButton setTitle:@"保存" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [addButton setBackgroundColor:[UIColor clearColor]];
    [addButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:addButton];
    
}
-(void)baocun{
    user.nicheng = self.nicheng.text;
    user.nianling = self.nianling.text;
    user.xueyuan = xueYuanSelect;
    user.xinqing = self.xinqing.text;
    user.sex = xingbieStr;
    
    NSError *error = nil;
    if ([app.managedObjectContext save:&error] ) {
        NSLog(@"保存成功");
        //如果成功 返回上一个界面
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        NSLog(@"添加userzhanghu对象到coredata出错 %@",error);
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmen:(UISegmentedControl *)sender {
    NSInteger Index = sender.selectedSegmentIndex;
    if (Index == 0) {
        xingbieStr = @"男";
    }else{
        xingbieStr = @"女";
    }

}
//限制字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.nicheng == textField)
    {
        if ([toBeString length] > 12) {
            textField.text = [toBeString substringToIndex:13];
            self.nameTiShi.hidden = NO;
            return NO;
            
        }else{
            self.nameTiShi.hidden = YES;
        }
    }

    return YES;
}
//判断文字长度
-  (int)convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    
    return (strlength+1)/2;
    
}



@end
