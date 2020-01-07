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

@class XFTableDataSource;
@interface XFTableAgent : NSObject

/// 客户（被委托人）
//@property (nonatomic, weak) id client;

- (void)agentTableView:(UITableView *)tableView
               rawData:(nullable id)rawData
         reformerClass:(Class<XFReformerInterface>)reformerClass
         eventDelegate:(id<XFTableEventDelegate>)eventDelegate;

/// 代理方法
/// @param tableView tableView
/// @param rawData 业务数据
/// @param reformerClass 格式化器类型
/// @param panelClass panel类型，可不传，如需拓展功能可自定义XFTablePanel的子类。
- (void)agentTableView:(UITableView *)tableView
               rawData:(nullable id)rawData
         reformerClass:(Class<XFReformerInterface>)reformerClass
            panelClass:(Class<XFTablePanelInterface>)panelClass
         eventDelegate:(id<XFTableEventDelegate>)eventDelegate;

- (void)reloadWithRawData:(id)rawData;

@end

NS_ASSUME_NONNULL_END
