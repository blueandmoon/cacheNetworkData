//
//  BaseModel.m
//  YeaLink
//
//  Created by 李根 on 16/4/24.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSMutableArray *)baseModelByArray:(NSArray *)arr {
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSDictionary *tempDic in arr) {
        @autoreleasepool {
            
            //  通过便利构造器来创建对象
            if (tempDic != (NSMutableDictionary *)[NSNull null]) {
                id model = [[self class] baseModelWithDic:tempDic];
                [modelArr addObject:model];
                
            }
        }
    }
    return modelArr;
    
}

+ (instancetype)baseModelWithDic:(NSDictionary *)dic {
    //  通过多态来创建对象
    id model = [[[self class] alloc] initWithDic:dic];
    return model;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        //  进行KVC的复制
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}





@end
