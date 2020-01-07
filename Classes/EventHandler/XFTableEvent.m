//
//  XFTableEvent.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "XFTableEvent.h"

@implementation XFAbstractEvent
@end

@implementation XFTableEvent

+ (instancetype)tableEventWithType:(XFEventType)type backData:(nullable id)data
{
    XFTableEvent *event = [[self alloc] init];
    event.type = type;
    event.data = data;
    return event;
}

@end

@implementation XFTableSectionEvent

+ (instancetype)cellEventWithType:(XFEventType)type backData:(nullable id)data atSection:(NSUInteger)section
{
    XFTableSectionEvent *event = [[self alloc] init];
    event.type = type;
    event.data = data;
    event.section = section;
    return event;
}

@end

@implementation XFTableCellEvent

+ (instancetype)cellEventWithType:(XFEventType)type backData:(nullable id)data atIndexPath:(NSIndexPath *)indexPath
{
    XFTableCellEvent *event = [[self alloc] init];
    event.type = type;
    event.data = data;
    event.indexPath = indexPath;
    return event;
}

@end
