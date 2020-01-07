//
//  XFTablePanelInterface.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFTableEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@class XFTableInfo;
@protocol XFTablePanelInterface <NSObject, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

- (void)reloadWithInfo:(XFTableInfo *)info;

@optional
@property (nonatomic, strong) XFTableEventHandler *eventHandler;

@end

NS_ASSUME_NONNULL_END
