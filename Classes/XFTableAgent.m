//
//  XFTableAgent.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "XFTableAgent.h"
#import "XFTableDataSource.h"
#import "XFTablePanel.h"

@interface XFTableAgent ()<XFTableDataSourceDelegate>

@property (nonatomic, strong) XFTableDataSource *dataSource;

@property (nonatomic, strong) id<XFTablePanelInterface> panel;

@end

@implementation XFTableAgent

- (void)agentTableView:(UITableView *)tableView
               rawData:(nullable id)rawData
         reformerClass:(Class<XFReformerInterface>)reformerClass
            panelClass:(nullable Class<XFTablePanelInterface>)panelClass
         eventDelegate:(id<XFTableEventDelegate>)eventDelegate
{
    NSCParameterAssert(tableView);
    NSCParameterAssert(reformerClass);
    if (!panelClass) {
        panelClass = [XFTablePanel class];
    }
    self.panel = [[(Class)panelClass alloc] init];
    self.panel.tableView = tableView;
    tableView.delegate = self.panel;
    tableView.dataSource = self.panel;
    XFTableEventHandler *eventHandler = [[XFTableEventHandler alloc] init];
    eventHandler.delegate = eventDelegate;
    if ([self.panel respondsToSelector:@selector(setEventHandler:)]) {
        [self.panel setEventHandler:eventHandler];
    }
    
    id<XFReformerInterface> reformer = [[(Class)reformerClass alloc] init];
    self.dataSource = [[XFTableDataSource alloc] initWithRawData:rawData reformer:reformer delegate:self];
}

- (void)reloadWithRawData:(id)rawData
{
    [self.dataSource refreshWithRawData:rawData];
}

#pragma mark - XFTableDataSourceDelegate
- (void)dataSourceDidRefresh:(XFTableInfo *)tableInfo
{
    [self.panel reloadWithInfo:tableInfo];
}


@end
