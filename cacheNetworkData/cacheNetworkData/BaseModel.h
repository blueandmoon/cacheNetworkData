//
//  BaseModel.h
//  YeaLink
//
//  Created by 李根 on 16/4/24.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

//  把数组套字典的数据传给方法， 返回一个数组套model
+ (NSMutableArray *)baseModelByArray:(NSArray *)arr;





@end
