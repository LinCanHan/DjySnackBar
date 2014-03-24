//
//  LCHMenuDetailViewController.m
//  DjySnackBar
//
//  Created by 林灿涵 on 14-3-18.
//  Copyright (c) 2014年 林灿涵. All rights reserved.
//

#import "LCHMenuDetailViewController.h"

@interface LCHMenuDetailViewController ()

@end

@implementation LCHMenuDetailViewController

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
    //view初始化时给各个控件赋值.
    _picture.image = [UIImage imageNamed:_pictureText];
    _desc.text = _descText;
    _price.text = _priceText;
    _name.text = _nameText;
    
    //定义返回按钮.
    self.navigationItem.leftBarButtonItem.title = @"返回";
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
