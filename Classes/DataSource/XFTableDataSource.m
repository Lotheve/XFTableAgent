//
//  XFTableDataSource.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "XFTableDataSource.h"
#import "XFTableInfo.h"

@interface XFTableDataSource ()

@property (nonatomic, weak) id<XFTableDataSourceDelegate> delegate;

@property (nonatomic, strong) XFTableInfo *tableInfo;

@property (nonatomic, strong) id<XFReformerInterface> reformer;

@end

@implementation XFTableDataSource

- (instancetype)initWithRawData:(nullable id)data reformer:(id<XFReformerInterface>)reformer delegate:(id<XFTableDataSourceDelegate>)delegate
{
    NSCParameterAssert(reformer);
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.reformer = reformer;
        self.tableInfo = [reformer reformRawData:data];
    }
    return self;
}

- (void)refreshWithRawData:(id)data
{
    if (data) {
        self.tableInfo = [self.reformer reformRawData:data];
    }
}

- (void)setTableInfo:(XFTableInfo *)tableInfo
{
    if (tableInfo != _tableInfo) {
        _tableInfo = tableInfo;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(dataSourceDidRefresh:)]) {
        [_delegate dataSourceDidRefresh:tableInfo];
    }
}

@end
