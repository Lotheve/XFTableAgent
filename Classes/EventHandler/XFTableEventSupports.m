//
//  XFTableEventSupports.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "XFTableEventSupports.h"
#import <objc/runtime.h>

static char XFTableEventHandlerKey;
static char XFSectionNumKey;

@implementation UIView (XFEvent)

- (XFTableEventHandler *)xf_eventHandler
{
    return objc_getAssociatedObject(self, &XFTableEventHandlerKey);
}

- (void)setXf_eventHandler:(XFTableEventHandler *)eventHandler
{
    objc_setAssociatedObject(self, &XFTableEventHandlerKey, eventHandler, OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)xf_section
{
    id section = objc_getAssociatedObject(self, &XFSectionNumKey);
    if (section) {
        return [((NSNumber *)section) integerValue];
    }
    return -1;
}

- (void)setXf_section:(NSInteger)section
{
    objc_setAssociatedObject(self, &XFSectionNumKey, @(section), OBJC_ASSOCIATION_ASSIGN);
}

@end

static char XFCellIndexPathKey;

@implementation UITableViewCell (XFEvent)

- (NSIndexPath *)xf_indexPath
{
    return objc_getAssociatedObject(self, &XFCellIndexPathKey);
}

- (void)setXf_indexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, &XFCellIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

