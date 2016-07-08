//
//  NetWorkingTool.m
//  YeaLink
//
//  Created by 李根 on 16/4/26.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "NetWorkingTool.h"

@implementation NetWorkingTool
+ (void)getNetWorking:(NSString *)strURL block:(Block)getBlock {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL]];
//    //  采用NSURLSession写get请求
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
////        NSLog(@"%@", result);
//        getBlock(result);
//        
//    }];
//    [dataTask resume];
    /**
     *
     */
//    NSLog(@"strURL%@", strURL);
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data == nil) {
            NSLog(@"~~~~~data is nil");
        } else {
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
//            NSLog(@"%@", result);
            getBlock(result);
            
        }
    }];
}


+ (void)postNetWorkig:(NSString *)strURL bodyStr:(NSString *)bodyStr block:(Block)block {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL]];
    [request setHTTPMethod:@"POST"];
    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    //  用NSURLSession写一次
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
        block(result);
    }];
}

//  把获取到的原生data传回去
+ (void)postNetWorkigDoNothing:(NSString *)strURL bodyStr:(NSString *)bodyStr block:(Block)block {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL]];
    [request setHTTPMethod:@"POST"];
    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    //  用NSURLSession写一次
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        NSLog(@"data: %@", data);
//        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONWritingPrettyPrinted error:nil];
        NSString *tempStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        block(tempStr);
    }];
}


@end
