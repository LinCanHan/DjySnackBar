//
//  LCHMessagesViewController.m
//  DjySnackBar
//
//  Created by 林灿涵 on 14-3-23.
//  Copyright (c) 2014年 林灿涵. All rights reserved.
//

#import "LCHMessagesViewController.h"
#import "BMapKit.h"
#import "LCHRouteAnnotation.h"

@interface LCHMessagesViewController ()


@end

@implementation LCHMessagesViewController

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
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }

	// Do any additional setup after loading the view.
    //创建mapView
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 350)];
    //设置定位
    [_mapView setShowsUserLocation:YES];
    //调用搜索路线函数
    [self routeSearch];
    //将view添加到Controllerview中
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}


//普通态
-(IBAction)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}
/*
//跟随态
-(IBAction)startFollowing:(id)sender
{
    NSLog(@"进入跟随态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}
 */

#pragma mark 节点搜索函数
-(void)routeSearch
{
    _mapView.delegate = self;
    _search = [[BMKSearch alloc]init];
    _search.delegate = self;
    //发起步行检索
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //CLLocationCoordinate2D mypt = (CLLocationCoordinate2D){37.791485,122.400012 };
    start.name = @"杨柳河街";
    //start.pt = mypt;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = @"杨柳河街";
    //end.pt= mypt;
    [_search walkingSearch:@"都江堰" startNode:start endCity:@"都江堰" endNode:end];

}

#pragma mark 节点绘制函数
- (void)onGetWalkingRouteResult:(BMKSearch*)searcher result:(BMKPlanResult*)result errorCode:(int)error
{
    // 在此处添加您对步行方案结果的处理
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
        
		LCHRouteAnnotation* item = [[LCHRouteAnnotation alloc]init];
		item.coordinate = result.startNode.pt;
		item.title = @"起点";
		item.type = 0;
		[_mapView addAnnotation:item];
		//[item release];
		
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = [[LCHRouteAnnotation alloc]init];
				item.coordinate = step.pt;
				item.title = step.content;
				item.degree = step.degree * 30;
				item.type = 4;
				[_mapView addAnnotation:item];
				//[item release];
			}
			
		}
		
		item = [[LCHRouteAnnotation alloc]init];
		item.coordinate = result.endNode.pt;
		item.type = 1;
		item.title = @"终点";
		[_mapView addAnnotation:item];
		//[item release];
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
        [_mapView setCenterCoordinate:result.startNode.pt animated:YES];
	}

}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
	if (userLocation != nil) {
		NSLog(@"%f %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
	}
	
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}




@end
