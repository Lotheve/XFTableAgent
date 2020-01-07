//
//  XFTablePanel.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "XFTablePanelInterface.h"
@class XFTableInfo;

NS_ASSUME_NONNULL_BEGIN

/**
 默认面板，实现了tableView常规的代理，如需拓展可以继承该类
 */
@interface XFTablePanel : NSObject <XFTablePanelInterface>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) XFTableEventHandler *eventHandler;

- (void)reloadWithInfo:(XFTableInfo *)info;

@end

NS_ASSUME_NONNULL_END
