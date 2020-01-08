//
//  XFHeadFoot.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Header/Footer Model
 */
@interface XFHeadFoot : NSObject

/// 类名
@property (nonatomic, strong) NSString *className;

/// nib名（优先级nibName>className）
@property (nonatomic, strong) NSString *nibName;

/// 重用ID
@property (nonatomic, copy) NSString *reuseID;

/// 视图高度（若需要动态计算高度，业务方可继承重写）
@property (nonatomic, assign) CGFloat viewHeight;

/// 业务原始数据 任意类型
@property (nonatomic, strong) id rawData;

@end

NS_ASSUME_NONNULL_END
