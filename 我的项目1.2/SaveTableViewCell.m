//
//  SaveTableViewCell.m
//  我的项目1.2
//
//  Created by 冯学杰 on 16/1/11.
//  Copyright © 2016年 冯学杰. All rights reserved.
//

#import "SaveTableViewCell.h"

@implementation SaveTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath*)index
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 16.5, 100, 15)];
        [self.contentView addSubview:titleLabel];
        titleLabel.font = [LCFont systemFontOfSize:15];
        
        self.contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.x+titleLabel.width, 8, SCREEN_WIDTH-15-titleLabel.x-titleLabel.width, 30)];
        self.contentTextField.borderStyle = UITextBorderStyleRoundedRect;
        
        [self.contentView addSubview:self.contentTextField];
        
        UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.x+titleLabel.width, 8, SCREEN_WIDTH-15-titleLabel.x-titleLabel.width, 30)];
        saveLabel.hidden = YES;
        saveLabel.text = @"您第一次乘坐火车的目的地";
        [self.contentView addSubview:saveLabel];
        
        if (index.section == 0) {
            if (index.row == 0) {
                titleLabel.text = @"安全问题";
                self.contentTextField.hidden = YES;
                saveLabel.hidden = NO;
                
            }
            if (index.row == 1) {
                titleLabel.text = @"请输入答案";
                self.contentTextField.placeholder = @"请输入答案";
                saveLabel.hidden = YES;
                self.contentTextField.hidden = NO;
            }
        }
        
        if (index.section == 1) {
            if (index.row == 0) {
                titleLabel.text = @"请输入新密码";
                self.contentTextField.placeholder = @"请输入新密码";
            }
            if (index.row == 1) {
                titleLabel.text = @"再输入新密码";
                self.contentTextField.placeholder = @"再输入新密码";
            }
        }
    }
    return self;
}
@end
