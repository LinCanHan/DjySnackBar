//
//  LCHDataModel.h
//  DjySnackBar
//
//  Created by 林灿涵 on 14-3-16.
//  Copyright (c) 2014年 林灿涵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHDataModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *price;

-(id)initWithDict:(NSDictionary *)dict;
+(id)LCHDataModelWithDict:(NSDictionary *)dict;

@end
