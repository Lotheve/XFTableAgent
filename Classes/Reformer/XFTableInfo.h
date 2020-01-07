//
//  XFTableInfo.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFSection.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Table Model
 Tip
 XFTableInfo具体格式如下:
 XFTableInfo: [XFSection,HFSection,...]
 XHSection: [XFHeadFoot,[HFRow,HFRow,...],XFHeadFoot]  两个XFHeadFoot分别对应头视图和尾视图的模型
 */
@interface XFTableInfo : NSObject

/// seciton models
@property (nonatomic, copy) NSArray<XFSection *> *sections;

/// section数
- (NSUInteger)numberOfSections;

@end

NS_ASSUME_NONNULL_END
