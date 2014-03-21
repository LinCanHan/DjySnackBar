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
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"SnackBarData" ofType:@"plist"];
    _dicts = [NSMutableArray arrayWithContentsOfFile:path];
    _dataModes = [NSMutableArray array];
    
    //把被选中的数据存储到我们的删除数组中.
    _deleteSnacks = [NSMutableArray array];
    
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
    
    if([_deleteSnacks containsObject:lchDatamodel]&& _deleteSnacks != nil){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{//不打勾
        cell.accessoryType = UITableViewCellStateShowingDeleteConfirmationMask;
    }
    
    
    cell.textLabel.text = lchDatamodel.name;
    cell.detailTextLabel.text = lchDatamodel.desc;
    
    cell.imageView.image = [UIImage imageNamed:lchDatamodel.icon];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    //给
    lchDetailMenuController.nameText = dataModel.name;
    lchDetailMenuController.descText = dataModel.desc;
    lchDetailMenuController.priceText = dataModel.price;
    lchDetailMenuController.pictureText = dataModel.icon;
    
}




@end
