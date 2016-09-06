//
//  TestModel.h
//  cacheNetworkData
//
//  Created by 李根 on 16/7/11.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "BaseModel.h"

@interface TestModel : BaseModel
@property(nonatomic, strong)NSString *GUID;
@property(nonatomic, strong)NSString *SeviceName;
@property(nonatomic, strong)NSString *ServiceLogo;
@property(nonatomic, strong)NSString *SeviceAddress;
@property(nonatomic, strong)NSString *IsHave;
@property(nonatomic, strong)NSString *UnreadCount;

@end
