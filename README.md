# XFTableAgent

> 将table view逻辑从控制器中剥离，提供统一接入方式，达到控制器瘦身的目的。

## 出发点

工程中table view作为最容易被业务"关照"的系统控件之一，使用频率高。同时table view本身是复杂的，功能强大（复杂与强大往往并存），因此table view相关的逻辑代码容易占据控制器的"半壁江山"。而MVC架构演变之路告诉我们，控制器应当尽可能"瘦"。故我们希望把table view的代码从控制器中剥离，统一交由一个table agent来整合逻辑，同时希望能够提供一种较为抽象的、无侵入性（主要考虑对业务数据结构的侵入）的方式供各业务场景使用。

## 整体结构

### 基本结构

从数据流向的角度看，C与V的关系，无非就是C把数据给V进行展示，V接收交互事件产生数据变更或事件告知V进行处理。table view本身作为V，固封装的抽象主要基于两点：

1. 接收数据并展示
2. 向上层传递产生的事件

至于其他处理细节，都是框架内部逻辑，应该对上层屏蔽。基本结构如下：

![结构图](<http://lotheve.cn/blog/xftableagent/structure.png>)

- Agent：与上层交互的table代理对象。接收table view实例以及原始数据，交于内部进行格式化封装然后展示；开放事件代理对象接口，供上层接收table view产生的事件。
- DataSource：数据源对象。用于管理原始数据，当数据发生变动时，通知Agent进行界面更新。
- Reformer：格式化器，用于统一表格信息（包含表格结构信息以及原始数据）。一方面，由于不同的业务场景，原始数据五花八门，我们无法也不应该要求业务方对原始数据进行统一，因此内部并不会对袁术数据格式进行转换，保证对原始业务数据格式的无侵入。另一方面，框架本身需要抽象的结构格式才能统一逻辑进行封装，因此内部必定需要统一格式的表格信息。Reformer的职责就是构建统一格式表格结构信息同时包装原始数据。具体的转换是由业务方来做的，框架仅提供抽象的格式要求（这里存在一定的使用成本）。
- panel：面板，基于封装好的表格信息，统一处理table view的逻辑。
- EventHandler：事件处理器。当table产生事件时，EventHandler事先接收到事件。考虑到具体业务中大部分场景都是由控制器进行事件的处理（例如Cell点击事件触发控制器push一个新的页面），因此EventHandler做的事情纯碎是将事件抛出给业务方的事件代理对象，这个代理对象是由Agent接收的。

### 关键类说明

#### XFTableAgent

> 面向业务，负责与上层的交互。仅提供两个接口：1、为table view设置代理，接收业务数据、表格信息格式化器、panel类型以及事件代理对象；2、提供刷新UI的接口。内部持有一个数据源对象和Panel对象，前者负责数据，后者负责渲染。

```objc
@interface XFTableAgent : NSObject

/// 代理table view
/// @param tableView tableView
/// @param rawData 业务数据
/// @param reformerClass 格式化器类型
/// @param panelClass panel类型，可不传，当需拓展table view功能可自定义XFTablePanel的子类。
/// @param eventDelegate 事件代理对象
- (void)agentTableView:(UITableView *)tableView
               rawData:(nullable id)rawData
         reformerClass:(Class<XFReformerInterface>)reformerClass
            panelClass:(nullable Class<XFTablePanelInterface>)panelClass
         eventDelegate:(id<XFTableEventDelegate>)eventDelegate;

/// 刷新界面
/// @param rawData 业务数据
- (void)reloadWithRawData:(id)rawData;

@end
```

#### XFTableDataSource

> 维护了数据源，即表格信息。表格信息是由传入的格式化器Reformer以及原始数据构建而成的。当业务数据发生变动，会有Agent告知DataSource对象更新数据源，而后通知Panel进行重绘。

```objc
@protocol XFTableDataSourceDelegate <NSObject>
/// 数据源更新
- (void)dataSourceDidRefresh:(XFTableInfo *)tableInfo;
@end

@interface XFTableDataSource : NSObject

/// 构造器
/// @param data 源数据
/// @param reformer 格式化器
/// @param delegate 数据源更新代理对象
- (instancetype)initWithRawData:(nullable id)data reformer:(id<XFReformerInterface>)reformer delegate:(id<XFTableDataSourceDelegate>)delegate;

/// 更新数据源
/// @param data 源数据
- (void)refreshWithRawData:(id)data;

@end
```

#### XFReformer

> 提供了表格信息构建的抽象接口，同时提供了表格信息的目标格式模型。业务方需要根据实际需求，通过继承XFReformer来实现具体的表格信息构建逻辑。

```objc
@protocol XFReformerInterface <NSObject>

/// 表格信息构建接口
/// @param data 原始数据
- (XFTableInfo *)reformRawData:(nullable id)data;

@end
```

`XFTableInfo`格式如下：

```objc
@interface XFTableInfo : NSObject

/// seciton models
@property (nonatomic, copy) NSArray<XFSection *> *sections;

/// section数
- (NSUInteger)numberOfSections;

@end
```

`XFSection`格式如下：

```objc
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
```

`XFHeadFoot`格式如下：

```objc
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
```

`XFRow`格式如下：

```objc
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
```

表格信息虽层次较多，不过结构清晰，与table view界面结构对应，使用门槛不高。大致结构如下：

```
XFTableInfo: [XFSection,HFSection,...]
XHSection: [XFHeadFoot,[HFRow,HFRow,...],XFHeadFoot]
```

#### XFTablePanel

> 之所以取名叫Panel，是因为它的职责就是负责table view的渲染展示。内部实现了table view常规的一些渲染逻辑，如需拓展table view的功能，业务可以继承XFTablePanel实现更多代理，这也是为何Agent提供的接口开放了一个panelClass参数的原因。另外，Panel还维护了一个事件处理器，并会将其传递给table中的各个界面元素，当界面产生交互事件时，将事件交由事件处理器进行处理。

```objc
@interface XFTablePanel : NSObject <XFTablePanelInterface>

/// table view
@property (nonatomic, strong) UITableView *tableView;

/// 事件处理器
@property (nonatomic, strong) XFTableEventHandler *eventHandler;

/// 重新渲染
/// @param info 表格信息
- (void)reloadWithInfo:(XFTableInfo *)info;

@end
```

以cell展示逻辑为例，内部实现如下：

```objc
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFRow *row;
    if (indexPath.section < _tableInfo.sections.count) {
        if (indexPath.row < _tableInfo.sections[indexPath.section].rows.count) {
            row = _tableInfo.sections[indexPath.section].rows[indexPath.row];
        }
    }
    if (row) {
        UITableViewCell *cell;
        if (row.reuseID) {
            cell = [tableView dequeueReusableCellWithIdentifier:row.reuseID];
            if (!cell) {
                if (row.nibName && row.nibName.length > 0) {
                    UINib *nib = [UINib nibWithNibName:row.nibName bundle:nil];
                    if (nib) {
                        [tableView registerNib:nib forCellReuseIdentifier:row.reuseID];
                        goto Finish_Register;
                    }
                }
                if (row.className && row.className.length > 0) {
                    [tableView registerClass:NSClassFromString(row.className) forCellReuseIdentifier:row.reuseID];
                }
            Finish_Register:
                cell = [tableView dequeueReusableCellWithIdentifier:row.reuseID];
            }
        } else {
            if (row.nibName && row.nibName.length > 0) {
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:row.nibName owner:nil options:nil];
                if (nibs.count > 0) {
                    cell = nibs[0];
                    goto Finish_Alloc;
                }
            }
            if (row.className && row.className.length > 0) {
                Class class = NSClassFromString(row.className);
                NSAssert([class isSubclassOfClass:[UITableViewCell class]], @"类型错误，请确保UITableViewCell类型");
                cell = [((UITableViewCell *)[class alloc]) init];
            }
        }
    Finish_Alloc:
        if (cell) {
            cell.xf_eventHandler = _eventHandler;
            cell.xf_indexPath = indexPath;
            if ([[cell class] conformsToProtocol:@protocol(XFTableItemInterface)] && [cell respondsToSelector:@selector(fillWithData:)]) {
                [cell performSelector:@selector(fillWithData:) withObject:row.rawData];
            }
            return cell;
        }
    }
    return [UITableViewCell new];
}
```

#### XFTableEventHandler

> 当事件产生时，由事件处理器来处理事件，目前的做法是直接抛给上层事件代理对象处理。每个事件都是XFTableEvent的实例，根据界面元素类型将事件划分为了Cell事件、Section事件、table事件，主要区别在与不同事件携带的参数会有不同，例如Cell事件需要携带具体Cell所处的IndexPath。另外，事件需要有type来表示事件类型，上层也是根据type来区分事件的。而实际场景中，事件类型是由业务决定的，例如某个业务场景下Cell里有button，该button事件就属于业务事件。目前框架内部只定义了Cell点击事件，其他事件均需业务方根据需求自行定义。

```objc
@interface XFTableEventHandler : NSObject

/// 事件代理对象
@property (nonatomic, weak) id<XFTableEventDelegate> delegate;

/// 处理Table事件
- (void)postTableEvent:(XFTableEvent *)event;

/// 处理Section事件
- (void)postSectionEvent:(XFTableSectionEvent *)event;

/// 处理Cell事件
- (void)postCellEvent:(XFTableCellEvent *)event;

@end
```

## 业务集成

#### 必要操作

- 构建表格信息

    表格信息是表格渲染的充分必要条件，不管表格是否需要展示业务数据，都得构建一份表格信息。构建方式：创建一个Reformer类继承自XFReformer，并重写`reformRawData:`方法自定义表格信息。具体可参照Demo中的`BusinessReformer`。

#### 非必要操作

- 界面元素填充数据

    Cell/Header/Footer根据需要实现`XFTableItemInterface`接口，接口定义了填充数据的方法，若界面元素需要填充数据，则需要该方法。对于无需填充数据的界面元素，无需实现该接口。

- 自定义事件类型

    对于业务需要的事件，需要业务方自行定义事件类型，事件类型为`XFEventType`。建议以table view为业务粒度进行统一维护，避免同一table view上的业务事件类型定义重复。另外，不同table view之间无需担心定义的事件类型会重复。 

- table view功能拓展

    框架支持常规的table view逻辑，table事件也仅支持Cell点击事件，如需拓展table view功能，业务方可自定义类继承自`XFTablePanel`，实现拓展的table view代理逻辑。

## Demo运行

执行 `pod install`  ，即可运行。

