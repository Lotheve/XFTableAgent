//
//  FooterView1.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "FooterView1.h"

@implementation FooterView1

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
    self.backgroundView.backgroundColor = [UIColor lightGrayColor];
}

@end
