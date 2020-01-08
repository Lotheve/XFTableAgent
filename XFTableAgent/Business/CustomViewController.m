//
//  CustomViewController.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/7.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "CustomViewController.h"
#import "TestModel.h"
#import "XFTableAgent.h"
#import "BusinessReformer.h"
#import "BusinessEventTypeDefine.h"

@interface CustomViewController () <XFTableEventDelegate>

@property (nonatomic, strong) UITableView *tableMain;

@property (nonatomic, strong) XFTableAgent *tableAgent;

@property (nonatomic, strong) NSArray <NSArray <TestModel *>*>*rawData; //原始业务数据

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setupUI
{
    [self.view addSubview:self.tableMain];
    self.tableAgent = [[XFTableAgent alloc] init];
    [self.tableAgent agentTableView:self.tableMain rawData:self.rawData reformerClass:[BusinessReformer class] panelClass:nil eventDelegate:self];
}

- (void)loadData
{
#define T @"title"
#define C @"content"
    /** mock data **/
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *jsonData1 = @[@{T:@"标题1",C:@"内容1"},
                            @{T:@"标题2",C:@"内容2"},
                            @{T:@"",C:@"内容3"},
                            @{T:@"标题4",C:@"内容4"},
                            @{T:@"",C:@"内容5"},
                            @{T:@"标题6",C:@"内容6"}];
        NSArray *jsonData2 = @[@{C:@"测试1"},
                            @{C:@"测试2"},
                            @{C:@"测试3"},
                            @{C:@"测试4"}];
        NSMutableArray *mData1 = [NSMutableArray arrayWithCapacity:jsonData1.count];
        [jsonData1 enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TestModel *model = [[TestModel alloc] init];
            model.title = obj[T] ? : @"";
            model.content = obj[C] ? : @"";
            [mData1 addObject:model];
        }];
        NSMutableArray *mData2 = [NSMutableArray arrayWithCapacity:jsonData2.count];
        [jsonData2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TestModel *model = [[TestModel alloc] init];
            model.title = obj[T] ? : @"";
            model.content = obj[C] ? : @"";
            [mData2 addObject:model];
        }];
        self.rawData = @[[mData1 copy], [mData2 copy]];
        [self.tableAgent reloadWithRawData:self.rawData];   //刷新table
    });
}

#pragma mark - XFTableEventDelegate
- (void)receiveTableEvent:(XFTableEvent *)event
{
}

- (void)receiveSectionEvent:(XFTableSectionEvent *)event
{
}

- (void)receiveCellEvent:(XFTableCellEvent *)event
{
    if (event.type == XFCellEventTypeDidSelected) {
        NSLog(@"%zi-%zi",event.indexPath.section, event.indexPath.row);
    } else if (event.type == BusinessCellEventTypeCell2_1ButtonDidClick) {
        NSLog(@"%@",((TestModel *)event.data).content);
    }
}

#pragma mark - Lazy
- (UITableView *)tableMain
{
    if (!_tableMain) {
        _tableMain = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableMain.tableFooterView = [UIView new];
    }
    return _tableMain;
}

@end
