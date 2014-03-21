//
//  LCHMenuDetailViewController.h
//  DjySnackBar
//
//  Created by 林灿涵 on 14-3-18.
//  Copyright (c) 2014年 林灿涵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCHMenuDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (strong,nonatomic)NSString *priceText;

@property (strong,nonatomic)NSString *pictureText;

@property (strong,nonatomic)NSString *descText;

@property (strong,nonatomic)NSString *nameText;



@end
