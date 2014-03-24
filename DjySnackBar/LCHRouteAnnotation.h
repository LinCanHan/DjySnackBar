//
//  LCHRouteAnnotation.h
//  DjySnackBar
//
//  Created by 林灿涵 on 14-3-24.
//  Copyright (c) 2014年 林灿涵. All rights reserved.
//

#import "BMKPointAnnotation.h"

@interface LCHRouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
	int _degree;

}
@property (nonatomic) int type;
@property (nonatomic) int degree;
@end
