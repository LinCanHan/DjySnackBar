//
//  LCHDataModel.m
//  DjySnackBar
//
//  Created by 林灿涵 on 14-3-16.
//  Copyright (c) 2014年 林灿涵. All rights reserved.
//

#import "LCHDataModel.h"

@implementation LCHDataModel
-(id)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
        self.desc = dict[@"desc"];
        self.price = dict[@"price"];
        
    }
    return self;
}
+(id)LCHDataModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
