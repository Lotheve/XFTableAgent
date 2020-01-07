//
//  XFTableEventSupports.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XFTableEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XFEvent)

@property (nonatomic, weak) XFTableEventHandler *xf_eventHandler;

@property (nonatomic, assign) NSInteger xf_section;

@end

@interface UITableViewCell (XFEvent)

@property (nonatomic, strong) NSIndexPath *xf_indexPath;

@end

NS_ASSUME_NONNULL_END
