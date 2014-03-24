//
//  LCHMessagesViewController.h
//  DjySnackBar
//
//  Created by 林灿涵 on 14-3-23.
//  Copyright (c) 2014年 林灿涵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface LCHMessagesViewController : UIViewController <BMKMapViewDelegate,BMKSearchDelegate>

//百度地图apiMapView对象
@property (strong,nonatomic)BMKMapView *mapView;
//百度地图search对象.
@property (strong,nonatomic)BMKSearch *search;
@end
