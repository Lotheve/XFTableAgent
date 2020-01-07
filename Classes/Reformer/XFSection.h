//
//  XFSection.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFRow.h"
#import "XFHeadFoot.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Section Model
 */
@interface XFSection : NSObject

/// cell models
@property (nonatomic, copy) NSArray<XFRow *> *rows;

/// head model
@property (nonatomic, strong) XFHeadFoot *head;

/// foot model
@property (nonatomic, strong) XFHeadFoot *foot;

/// row数
- (NSUInteger)numberOfRows;
 
@end

NS_ASSUME_NONNULL_END
