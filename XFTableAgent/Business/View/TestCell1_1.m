//
//  TestCell1_1.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "TestCell1_1.h"
#import <Masonry.h>
#import "TestModel.h"

@interface TestCell1_1 ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation TestCell1_1

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(8);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(64);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(12);
        make.centerY.equalTo(self.titleLabel);
        make.right.mas_equalTo(16);
        make.top.mas_equalTo(8);
    }];
}

#pragma mark - XFTableItemInterface
- (void)fillWithData:(id)data
{
    if ([data isKindOfClass:[TestModel class]]) {
        TestModel *m = (TestModel *)data;
        self.titleLabel.text = m.title;
        self.contentLabel.text = m.content;
    }
}

#pragma mark - Lazy
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.textColor = [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1];
    }
    return _titleLabel;
}

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

@end
