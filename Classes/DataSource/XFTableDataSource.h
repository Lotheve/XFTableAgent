//
//  XFTableDataSource.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XFReformerInterface.h"

NS_ASSUME_NONNULL_BEGIN
@class XFTableInfo;
@protocol XFTableDataSourceDelegate <NSObject>

/// 数据源更新
- (void)dataSourceDidRefresh:(XFTableInfo *)tableInfo;

@end

@interface XFTableDataSource : NSObject

- (instancetype)initWithReformer:(id<XFReformerInterface>)reformer delegate:(id<XFTableDataSourceDelegate>)delegate;

- (instancetype)initWithRawData:(nullable id)data reformer:(id<XFReformerInterface>)reformer delegate:(id<XFTableDataSourceDelegate>)delegate;

- (void)refreshWithRawData:(id)data;

@end

NS_ASSUME_NONNULL_END
