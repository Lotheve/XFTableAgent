//
//  XFTableEventHandler.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "XFTableEventHandler.h"

@implementation XFTableEventHandler

- (void)postTableEvent:(XFTableEvent *)event
{
    if (!event) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(receiveTableEvent:)]) {
        [self.delegate receiveTableEvent:event];
    }
}

- (void)postSectionEvent:(XFTableSectionEvent *)event
{
    if (!event) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(receiveSectionEvent:)]) {
        [self.delegate receiveSectionEvent:event];
    }
}

- (void)postCellEvent:(XFTableCellEvent *)event
{
    if (!event) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(receiveCellEvent:)]) {
        [self.delegate receiveCellEvent:event];
    }
}

@end
