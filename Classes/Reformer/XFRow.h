//
//  XFRow.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Cell Model
 */
@interface XFRow : NSObject

/// 类名
@property (nonatomic, strong) NSString *className;

/// nib名（优先级nibName>className）
@property (nonatomic, strong) NSString *nibName;

/// 重用ID
@property (nonatomic, copy) NSString *reuseID;

/// 行高（若需要动态计算高度，业务方可继承重写）
@property (nonatomic, assign) CGFloat rowHeight;

/// 业务原始数据 任意类型
@property (nonatomic, strong) id rawData;

@end

NS_ASSUME_NONNULL_END
