//
//  TestCell2_2.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "TestCell2_2.h"
#import "TestModel.h"

@implementation TestCell2_2

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - XFTableItemInterface
- (void)fillWithData:(id)data
{
    if ([data isKindOfClass:[TestModel class]]) {
        TestModel *m = (TestModel *)data;
        self.labelContent.text = m.content;
    }
}


@end
