//
//  TestCell2_2.h
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTableItemInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCell2_2 : UITableViewCell<XFTableItemInterface>

@property (weak, nonatomic) IBOutlet UILabel *labelContent;


@end

NS_ASSUME_NONNULL_END
