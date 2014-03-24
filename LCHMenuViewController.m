//
//  LCHMenuViewController.m
//  DjySnackBar
//
//  Created by 林灿涵 on 14-3-14.
//  Copyright (c) 2014年 林灿涵. All rights reserved.
//

#import "LCHMenuViewController.h"
#import "LCHDataModel.h"
#import "LCHMenuDetailViewController.h"

@interface LCHMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //菜品一览数据.
    NSMutableArray *_dicts;
    //数据模型对象引用.
    NSMutableArray *_dataModes;
    //删除对象保存数组
    NSMutableArray *_deleteSnacks;
}

@end

@implementation LCHMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //加载plist中的数据到模型对象.
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"SnackBarData" ofType:@"plist"];
    _dicts = [NSMutableArray arrayWithContentsOfFile:path];
    _dataModes = [NSMutableArray array];
    
    //把被选中的数据存储到我们的删除数组中.
    _deleteSnacks = [NSMutableArray array];
    //遍历加载菜品一览数据,将每一行数据作为一个模型对象加入模型对象数组.
    for(NSDictionary *dict in _dicts)
    {
        [_dataModes addObject:[LCHDataModel LCHDataModelWithDict:dict]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -数据源方法
#pragma mark 一共有多少组方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -第section一共有多少行数据.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataModes.count;
}

#pragma mark -返回每一行所显示的内容.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    //1.从缓存池中取出可循环利用的cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2.如果缓存池中没有可循环利用的cell,则单独创建.
    if(cell == nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    LCHDataModel *lchDatamodel  = _dataModes[indexPath.row];
    
    //当显示每一行cell的时候,判断当前被点击的这一行cell是否已经存在删除数组中.如果在的话,则更改这个cell的状态.
    if([_deleteSnacks containsObject:lchDatamodel]&& _deleteSnacks != nil){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{//不打勾
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    //把模型对象的数值赋值给我们的cell
    cell.textLabel.text = lchDatamodel.name;
    cell.detailTextLabel.text = lchDatamodel.desc;
    
    cell.imageView.image = [UIImage imageNamed:lchDatamodel.icon];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //设置导航栏名称.
    self.navigationItem.title = @"新繁牛肉豆花菜品一览";

    return cell;
}


#pragma mark 删除选中行数据
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}


#pragma mark 每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}




#pragma mark 选中了某一行cell就会调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //通过indexpath,得到数据模型中相应的数据.
    LCHDataModel *selectedDataModel = [_dataModes objectAtIndex:indexPath.row];
    
    //判断一下当前被点中的这一行cell是否已经被点击过了.若是的话,则从删除数组中去掉这个cell.如果没有则添加到删除数组中.
    if([_deleteSnacks containsObject:selectedDataModel])
    {
        [_deleteSnacks removeObject:selectedDataModel];
    }
    else
    {
        [_deleteSnacks addObject:selectedDataModel];
    }
    //刷新表格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    
}

#pragma mark 连线传递数据时会调用这个方法.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //选择触发事件的单元格进行初始化.
    NSIndexPath *indexpath = [self.tableView indexPathForCell:sender];
    //获取连线的实例
    LCHMenuDetailViewController *lchDetailMenuController = segue.destinationViewController;
    //从数据模型中拿出当前被点击这一行数据的cell的信息.
    LCHDataModel *dataModel = [_dataModes objectAtIndex:indexpath.row];
    //给目标对象的属性赋值.
    lchDetailMenuController.nameText = dataModel.name;
    lchDetailMenuController.descText = dataModel.desc;
    lchDetailMenuController.priceText = dataModel.price;
    lchDetailMenuController.pictureText = dataModel.icon;
    
}




@end
