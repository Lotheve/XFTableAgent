//
//  XFTableItemInterface.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 业务方的Cell/Header/Footer按需实现该接口
 */
@protocol XFTableItemInterface <NSObject>

@optional

/// 填充数据
/// @param data 原始业务数据 无侵入
- (void)fillWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
