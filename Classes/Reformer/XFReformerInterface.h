//
//  XFReformerInterface.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFTableInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XFReformerInterface <NSObject>

/// 数据格式转换 原始数据->TableInfo
/// @param data 原始数据
- (XFTableInfo *)reformRawData:(id)data;

@end

NS_ASSUME_NONNULL_END
