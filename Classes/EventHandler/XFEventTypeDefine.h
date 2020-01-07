//
//  XFEventTypeDefine.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 事件类型定义
///
/// 具体事件类型由业务决定，目前缺省仅支持cell的点击事件，业务方根据需要自行定义(建议以表格业务为粒度进行维护)
typedef NSInteger XFEventType;

extern const XFEventType XFCellEventTypeDidSelected;

NS_ASSUME_NONNULL_END
