//
//  TestModel.m
//  cacheNetworkData
//
//  Created by 李根 on 16/7/11.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "TestModel.h"
#import <objc/runtime.h>
#import "SerializeKit.h"

@implementation TestModel

SERIALIZE_DESCRIPTION();

SERIALIZE_COPY_WITH_ZONE();

SERIALIZE_CODER_DECODER();


@end
