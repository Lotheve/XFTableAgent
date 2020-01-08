//
//  XFTableAgent.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XFReformerInterface.h"
#import "XFTablePanelInterface.h"
#import "XFTableEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface XFTableAgent : NSObject

/// 代理table view
/// @param tableView tableView
/// @param rawData 业务数据
/// @param reformerClass 格式化器类型
/// @param panelClass panel类型，可不传，当需拓展table view功能可自定义XFTablePanel的子类。
/// @param eventDelegate 事件代理对象
- (void)agentTableView:(UITableView *)tableView
               rawData:(nullable id)rawData
         reformerClass:(Class<XFReformerInterface>)reformerClass
            panelClass:(nullable Class<XFTablePanelInterface>)panelClass
         eventDelegate:(id<XFTableEventDelegate>)eventDelegate;

/// 刷新界面
/// @param rawData 业务数据
- (void)reloadWithRawData:(id)rawData;

@end

NS_ASSUME_NONNULL_END
