//
//  BusinessReformer.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "BusinessReformer.h"
#import "TestModel.h"
#import "TestCell1_1.h"
#import "TestCell1_2.h"
#import "TestCell2_1.h"
#import "TestCell2_2.h"
#import "HeaderView1.h"
#import "HeaderView2.h"
#import "FooterView1.h"

@implementation BusinessReformer

- (XFTableInfo *)reformRawData:(id)data
{
    //配置XFTableInfo
    XFTableInfo *info = [XFTableInfo new];
    if (data) {
        NSArray *rawData = (NSArray *)data;
        NSMutableArray *sections = [NSMutableArray arrayWithCapacity:rawData.count];
        [rawData enumerateObjectsUsingBlock:^(NSArray<TestModel *>* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XFSection *section = [XFSection new];
            if (idx == 0) {
                XFHeadFoot *header = [XFHeadFoot new];
                header.className = NSStringFromClass([HeaderView1 class]);
                header.reuseID = [NSString stringWithFormat:@"%@ID",NSStringFromClass([HeaderView1 class])];
                header.viewHeight = 60;
                header.rawData = @"Section1";
                section.head = header;
                
                XFHeadFoot *footer = [XFHeadFoot new];
                footer.className = NSStringFromClass([FooterView1 class]);
                footer.reuseID = [NSString stringWithFormat:@"%@ID",NSStringFromClass([FooterView1 class])];
                footer.viewHeight = 20;
                section.foot = footer;
                
                NSMutableArray *rows = [NSMutableArray arrayWithCapacity:obj.count];
                [obj enumerateObjectsUsingBlock:^(TestModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                    XFRow *row = [XFRow new];
                    if (model.title && model.title.length > 0) {
                        row.className = NSStringFromClass([TestCell1_1 class]);
                        row.reuseID = [NSString stringWithFormat:@"%@ID",NSStringFromClass([TestCell1_1 class])];
                    } else {
                        row.className = NSStringFromClass([TestCell1_2 class]);
                        row.reuseID = [NSString stringWithFormat:@"%@ID",NSStringFromClass([TestCell1_2 class])];
                    }
                    row.rowHeight = 50;
                    row.rawData = model;
                    [rows addObject:row];
                }];
                section.rows = [rows copy];
            } else {
                XFHeadFoot *header = [XFHeadFoot new];
                header.className = NSStringFromClass([HeaderView2 class]);
                header.reuseID = [NSString stringWithFormat:@"%@ID",NSStringFromClass([HeaderView2 class])];
                header.viewHeight = 60;
                header.rawData = @"Section2";
                section.head = header;
                
                NSMutableArray *rows = [NSMutableArray arrayWithCapacity:obj.count];
                [obj enumerateObjectsUsingBlock:^(TestModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                    XFRow *row = [XFRow new];
                    if (idx < 2) {
                        row.className = NSStringFromClass([TestCell2_1 class]);
                        row.reuseID = [NSString stringWithFormat:@"%@ID",NSStringFromClass([TestCell2_1 class])];
                    } else {
                        row.nibName = NSStringFromClass([TestCell2_2 class]);
                        row.reuseID = [NSString stringWithFormat:@"%@ID",NSStringFromClass([TestCell2_2 class])];
                    }
                    row.rowHeight = 50;
                    row.rawData = model;
                    [rows addObject:row];
                }];
                section.rows = [rows copy];
            }
            
            [sections addObject:section];
        }];
        info.sections = [sections copy];
    }
    return info;
}

@end
