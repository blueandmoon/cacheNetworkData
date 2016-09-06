//
//  TestJsonModel.h
//  cacheNetworkData
//
//  Created by 李根 on 16/7/12.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TestJsonModel : JSONModel

//@property(nonatomic, strong)NSArray *AdvList;
//@property(nonatomic, strong)NSArray *ServiceList;

@property(nonatomic, strong)NSString *GUID;
@property(nonatomic, strong)NSString *SeviceName;
@property(nonatomic, strong)NSString *ServiceLogo;
@property(nonatomic, strong)NSString *SeviceAddress;
@property(nonatomic, strong)NSString *IsHave;
@property(nonatomic, strong)NSString *UnreadCount;

@end
