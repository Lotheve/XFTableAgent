//
//  TestCell2_1.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "TestCell2_1.h"
#import <Masonry.h>
#import "TestModel.h"
#import "BusinessEventTypeDefine.h"
#import "XFTableEventSupports.h"

@interface TestCell2_1 ()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *doBtn;

@property (nonatomic, strong) TestModel *model;

@end

@implementation TestCell2_1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.doBtn];
    [self.doBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(64);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(8);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.doBtn).offset(-12);
    }];
}

- (void)actionDo
{
    if (self.xf_eventHandler) {
        //抛出事件
        XFTableCellEvent *event = [XFTableCellEvent cellEventWithType:BusinessCellEventTypeCell2_1ButtonDidClick backData:_model atIndexPath:self.xf_indexPath];
        [self.xf_eventHandler postCellEvent:event];
    }
}

#pragma mark - XFTableItemInterface
- (void)fillWithData:(id)data
{
    if ([data isKindOfClass:[TestModel class]]) {
        TestModel *m = (TestModel *)data;
        _model = m;
        self.contentLabel.text = m.content;
    }
}

#pragma mark - Lazy
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:16.0f];
        _contentLabel.textColor = [UIColor lightGrayColor];
    }
    return _contentLabel;
}

- (UIButton *)doBtn
{
    if (!_doBtn) {
        _doBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doBtn.backgroundColor = [UIColor orangeColor];
        _doBtn.layer.masksToBounds = YES;
        _doBtn.layer.cornerRadius = 3.0;
        _doBtn.layer.borderWidth = 1.0;
        _doBtn.layer.borderColor = [UIColor purpleColor].CGColor;
        [_doBtn setTitle:@"点我" forState:UIControlStateNormal];
        [_doBtn addTarget:self action:@selector(actionDo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doBtn;
}

@end
