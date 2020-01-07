//
//  XFTablePanel.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "XFTablePanel.h"
#import "XFTableInfo.h"
#import "XFTableItemInterface.h"
#import "XFTableEventSupports.h"

@interface XFTablePanel ()

@property (nonatomic, strong) XFTableInfo *tableInfo;

@end

@implementation XFTablePanel

#pragma mark - Public
- (void)reloadWithInfo:(XFTableInfo *)info
{
    if (_tableInfo != info) {
        _tableInfo = info;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)setEventHandler:(XFTableEventHandler *)eventHandler
{
    _eventHandler = eventHandler;
    _tableView.xf_eventHandler = eventHandler;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tableInfo numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < _tableInfo.sections.count) {
        return [_tableInfo.sections[section] numberOfRows];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < _tableInfo.sections.count) {
        if (indexPath.row < _tableInfo.sections[indexPath.section].rows.count) {
            return _tableInfo.sections[indexPath.section].rows[indexPath.row].rowHeight;
        }
    }
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFRow *row;
    if (indexPath.section < _tableInfo.sections.count) {
        if (indexPath.row < _tableInfo.sections[indexPath.section].rows.count) {
            row = _tableInfo.sections[indexPath.section].rows[indexPath.row];
        }
    }
    if (row) {
        UITableViewCell *cell;
        if (row.reuseID) {
            cell = [tableView dequeueReusableCellWithIdentifier:row.reuseID];
            if (!cell) {
                if (row.nibName && row.nibName.length > 0) {
                    UINib *nib = [UINib nibWithNibName:row.nibName bundle:nil];
                    if (nib) {
                        [tableView registerNib:nib forCellReuseIdentifier:row.reuseID];
                        goto Finish_Register;
                    }
                }
                if (row.className && row.className.length > 0) {
                    [tableView registerClass:NSClassFromString(row.className) forCellReuseIdentifier:row.reuseID];
                }
            Finish_Register:
                cell = [tableView dequeueReusableCellWithIdentifier:row.reuseID];
            }
        } else {
            if (row.nibName && row.nibName.length > 0) {
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:row.nibName owner:nil options:nil];
                if (nibs.count > 0) {
                    cell = nibs[0];
                    goto Finish_Alloc;
                }
            }
            if (row.className && row.className.length > 0) {
                Class class = NSClassFromString(row.className);
                NSAssert([class isSubclassOfClass:[UITableViewCell class]], @"类型错误，请确保UITableViewCell类型");
                cell = [((UITableViewCell *)[class alloc]) init];
            }
        }
    Finish_Alloc:
        if (cell) {
            cell.xf_eventHandler = _eventHandler;
            cell.xf_indexPath = indexPath;
            if ([[cell class] conformsToProtocol:@protocol(XFTableItemInterface)] && [cell respondsToSelector:@selector(fillWithData:)]) {
                [cell performSelector:@selector(fillWithData:) withObject:row.rawData];
            }
            return cell;
        }
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < _tableInfo.sections.count) {
        XFSection *sct = _tableInfo.sections[section];
        if (sct.head) {
            return sct.head.viewHeight;
        }
    }
    return CGFLOAT_MIN;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XFHeadFoot *header;
    if (section < _tableInfo.sections.count) {
        header = _tableInfo.sections[section].head;
    }
    if (header) {
        UIView *headerView;
        if (header.reuseID) {
            headerView = [tableView dequeueReusableCellWithIdentifier:header.reuseID];
            if (!headerView) {
                if (header.nibName && header.nibName.length > 0) {
                    UINib *nib = [UINib nibWithNibName:header.nibName bundle:nil];
                    if (nib) {
                        [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:header.reuseID];
                        goto Finish_Register;
                    }
                }
                if (header.className && header.className.length > 0) {
                    [tableView registerClass:NSClassFromString(header.className) forHeaderFooterViewReuseIdentifier:header.reuseID];
                }
            Finish_Register:
                headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header.reuseID];
            }
        } else {
            if (header.nibName && header.nibName.length > 0) {
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:header.nibName owner:nil options:nil];
                if (nibs.count > 0) {
                    headerView = nibs[0];
                    goto Finish_Alloc;
                }
            }
            if (header.className && header.className.length > 0) {
                Class class = NSClassFromString(header.className);
                NSAssert([class isSubclassOfClass:[UIView class]], @"类型错误，请确保UIView类型");
                headerView = [((UIView *)[class alloc]) init];
            }
        }
    Finish_Alloc:
        if (headerView) {
            headerView.xf_eventHandler = _eventHandler;
            headerView.xf_section = section;
            if ([[headerView class] conformsToProtocol:@protocol(XFTableItemInterface)] && [headerView respondsToSelector:@selector(fillWithData:)]) {
                [headerView performSelector:@selector(fillWithData:) withObject:header.rawData];
            }
            return headerView;
        }
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section < _tableInfo.sections.count) {
        XFSection *sct = _tableInfo.sections[section];
        if (sct.head) {
            return sct.foot.viewHeight;
        }
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    XFHeadFoot *footer;
    if (section < _tableInfo.sections.count) {
        footer = _tableInfo.sections[section].foot;
    }
    if (footer) {
        UIView *footerView;
        if (footer.reuseID) {
            footerView = [tableView dequeueReusableCellWithIdentifier:footer.reuseID];
            if (!footerView) {
                if (footer.nibName && footer.nibName.length > 0) {
                    UINib *nib = [UINib nibWithNibName:footer.nibName bundle:nil];
                    if (nib) {
                        [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:footer.reuseID];
                        goto Finish_Register;
                    }
                }
                if (footer.className && footer.className.length > 0) {
                    [tableView registerClass:NSClassFromString(footer.className) forHeaderFooterViewReuseIdentifier:footer.reuseID];
                }
            Finish_Register:
                footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footer.reuseID];
            }
        } else {
            if (footer.nibName && footer.nibName.length > 0) {
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:footer.nibName owner:nil options:nil];
                if (nibs.count > 0) {
                    footerView = nibs[0];
                    goto Finish_Alloc;
                }
            }
            if (footer.className && footer.className.length > 0) {
                Class class = NSClassFromString(footer.className);
                NSAssert([class isSubclassOfClass:[UIView class]], @"类型错误，请确保UIView类型");
                footerView = [((UIView *)[class alloc]) init];
            }
        }
    Finish_Alloc:
        if (footerView) {
            footerView.xf_eventHandler = _eventHandler;
            footerView.xf_section = section;
            if ([[footerView class] conformsToProtocol:@protocol(XFTableItemInterface)] && [footerView respondsToSelector:@selector(fillWithData:)]) {
                [footerView performSelector:@selector(fillWithData:) withObject:footer.rawData];
            }
            return footerView;
        }
    }
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    XFTableCellEvent *event = [XFTableCellEvent cellEventWithType:XFCellEventTypeDidSelected backData:nil atIndexPath:indexPath];
    [cell.xf_eventHandler postCellEvent:event];
}

@end
