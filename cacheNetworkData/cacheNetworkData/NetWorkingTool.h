//
//  NetWorkingTool.h
//  YeaLink
//
//  Created by 李根 on 16/4/26.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Block)(id result);

@interface NetWorkingTool : NSObject
//  get请求
+ (void)getNetWorking:(NSString *)strURL block:(Block)getBlock;

//  post请求
+ (void)postNetWorkig:(NSString *)strURL bodyStr:(NSString *)bodyStr block:(Block)block;

//  传回接收到的data
+ (void)postNetWorkigDoNothing:(NSString *)strURL bodyStr:(NSString *)bodyStr block:(Block)block;
@end
