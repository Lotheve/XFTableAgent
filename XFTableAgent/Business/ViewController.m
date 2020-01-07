//
//  ViewController.m
//  XFTableAgent
//
//  Created by 卢旭峰 on 2020/1/6.
//  Copyright © 2020 Lotheve. All rights reserved.
//

#import "ViewController.h"
#import "TestCell1_1.h"
#import "TestCell1_2.h"
#import "TestCell2_1.h"
#import "TestCell2_2.h"
#import "HeaderView1.h"
#import "HeaderView2.h"
#import "FooterView1.h"
#import "TestModel.h"

#import "CustomViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableMain;

@property (nonatomic, strong) NSArray <NSArray <TestModel *>*>*rawData; //原始业务数据 格式不受影响

@end

@implementation ViewController

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
        [self.tableMain reloadData];
    });
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _rawData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rawData[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TestModel *model = _rawData[indexPath.section][indexPath.row];
        if (model.title && model.title.length > 0) {
            TestCell1_1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestCell1_1 class])];
            [cell fillWithData:model];
            return cell;
        } else {
            TestCell1_2 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestCell1_2 class])];
            [cell fillWithData:model];
            return cell;
        }
    } else {
        TestModel *model = _rawData[indexPath.section][indexPath.row];
        if (indexPath.row < 2) {
            TestCell2_1 *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestCell2_1 class])];
            [cell fillWithData:model];
            return cell;
        } else {
            TestCell2_2 *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell2_2ID"];
            [cell fillWithData:model];
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        HeaderView1 *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([HeaderView1 class])];
        [headerView fillWithData:@"Section1"];
        return headerView;
    } else {
        HeaderView2 *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([HeaderView2 class])];
        [headerView fillWithData:@"Section2"];
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        FooterView1 *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([FooterView1 class])];
        return footerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }
    return CGFLOAT_MIN;
}

#pragma mark - Lazy
- (UITableView *)tableMain
{
    if (!_tableMain) {
        _tableMain = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableMain.delegate = self;
        _tableMain.dataSource = self;
        _tableMain.tableFooterView = [UIView new];
        [_tableMain registerClass:[TestCell1_1 class] forCellReuseIdentifier:NSStringFromClass([TestCell1_1 class])];
        [_tableMain registerClass:[TestCell1_2 class] forCellReuseIdentifier:NSStringFromClass([TestCell1_2 class])];
        [_tableMain registerClass:[TestCell2_1 class] forCellReuseIdentifier:NSStringFromClass([TestCell2_1 class])];
        [_tableMain registerNib:[UINib nibWithNibName:NSStringFromClass([TestCell2_2 class]) bundle:nil] forCellReuseIdentifier:@"TestCell2_2ID"];
        [_tableMain registerClass:[HeaderView1 class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([HeaderView1 class])];
        [_tableMain registerClass:[HeaderView2 class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([HeaderView2 class])];
        [_tableMain registerClass:[FooterView1 class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([FooterView1 class])];
    }
    return _tableMain;
}

@end
