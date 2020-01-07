//
//  TestCell1_2.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "TestCell1_2.h"
#import <Masonry.h>
#import "TestModel.h"

@interface TestCell1_2 ()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation TestCell1_2

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
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(16);
        make.top.mas_equalTo(8);
        make.centerY.equalTo(self.contentView);
    }];
}

#pragma mark - XFTableItemInterface
- (void)fillWithData:(id)data
{
    if ([data isKindOfClass:[TestModel class]]) {
        TestModel *m = (TestModel *)data;
        self.contentLabel.text = m.content;
    }
}

#pragma mark - Lazy
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:16.0f];
        _contentLabel.textColor = [UIColor lightGrayColor];
    }
    return _contentLabel;
}

@end
