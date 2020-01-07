//
//  HeaderView1.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "HeaderView1.h"
#import <Masonry.h>

@interface HeaderView1 ()

@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation HeaderView1

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundView = [UIView new];
    self.backgroundView.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).inset(8);
    }];
}

#pragma mark - XFTableItemInterface
- (void)fillWithData:(id)data
{
    if ([data isKindOfClass:[NSString class]]) {
        self.infoLabel.text = (NSString *)data;
    }
}

#pragma mark - Lazy
- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.font = [UIFont systemFontOfSize:22.0f weight:UIFontWeightBold];
        _infoLabel.textColor = [UIColor lightGrayColor];
    }
    return _infoLabel;
}

@end
