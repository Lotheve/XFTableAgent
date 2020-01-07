//
//  XFReformer.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFReformerInterface.h"

NS_ASSUME_NONNULL_BEGIN

/// 格式化器 将业务数据用TableInfo封装
/// 需要根据具体业务，创建子类，重写`reformRawData:`进行数据封装
@interface XFReformer : NSObject <XFReformerInterface>

@end

NS_ASSUME_NONNULL_END
