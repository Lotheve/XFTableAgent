//
//  XFTableEvent.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFEventTypeDefine.h"

NS_ASSUME_NONNULL_BEGIN

/**
 事件抽象基类
 */
@interface XFAbstractEvent : NSObject

/// 事件类型
@property (nonatomic, assign) XFEventType type;

/// 事件回传数据
@property (nonatomic, strong) id data;

@end

/**
 Table事件
 */
@interface XFTableEvent : XFAbstractEvent

+ (instancetype)tableEventWithType:(XFEventType)type backData:(nullable id)data;

@end

/**
 Section事件
 */
@interface XFTableSectionEvent : XFAbstractEvent

/// 事件源Cell的indexPath
@property (nonatomic, assign) NSUInteger section;

+ (instancetype)cellEventWithType:(XFEventType)type backData:(nullable id)data atSection:(NSUInteger)section;

@end

/**
 Cell事件
 */
@interface XFTableCellEvent : XFAbstractEvent

/// 事件源Cell的indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellEventWithType:(XFEventType)type backData:(nullable id)data atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
