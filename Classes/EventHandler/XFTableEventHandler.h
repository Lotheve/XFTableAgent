//
//  XFTableEventHandler.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFTableEvent.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XFTableEventDelegate <NSObject>

- (void)receiveTableEvent:(XFTableEvent *)event;
- (void)receiveSectionEvent:(XFTableSectionEvent *)event;
- (void)receiveCellEvent:(XFTableCellEvent *)event;

@end

/**
 事件处理器 用于处理TableView以及Cell产生的事件
 目前的事件处理方案是统一交由被代理方处理（通常是上层控制器）
 */
@interface XFTableEventHandler : NSObject

/// 事件代理对象
@property (nonatomic, weak) id<XFTableEventDelegate> delegate;

/// 处理Table事件
- (void)postTableEvent:(XFTableEvent *)event;

/// 处理Section事件
- (void)postSectionEvent:(XFTableSectionEvent *)event;

/// 处理Cell事件
- (void)postCellEvent:(XFTableCellEvent *)event;

@end

NS_ASSUME_NONNULL_END
