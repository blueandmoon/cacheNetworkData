//
//  ViewController.m
//  cacheNetworkData
//
//  Created by 李根 on 16/7/7.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "ViewController.h"
#import "NetWorkingTool.h"
#import "BaseModel.h"
#import "TestModel.h"
#import "SerializeKit.h"
#import "TestJsonModel.h"
#import <FMDB.h>
#import <FMDatabaseQueue.h>
#import <JSONModel/JSONModel.h>
#import <MJExtension/MJExtension.h>
#import "TestMJExtension.h"
#import "NetWorkingTool.h"

#define DATAURL @"http://wapi.go2family.com/api/APIAppIndex/GetAppIndexSeviceListByIOS?CityID=320500&AuthoLevel=2&UserID=18112572968"

#define DBNAME    @"personinfo.sqlite"
#define ID        @"id"
#define NAME      @"name"
#define AGE       @"age"
#define ADDRESS   @"address"
#define TABLENAME @"PERSONINFOMATION"



@interface ViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@end

@implementation ViewController
{
    FMDatabase *db;
    NSString *databasePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    
    _arr = [NSMutableArray array];
    
    
    [NetWorkingTool getNetWorking:DATAURL block:^(id result) {
//        _arr = [TestModel baseModelByArray:result[@"ServiceList"]];
//        SERIALIZE_ARCHIVE(_arr, @"netData", [self filePath]);
//    
//        NSMutableArray *descoderArr = [NSMutableArray array];
//        SERIALIZE_UNARCHIVE(descoderArr, @"netData", [self filePath]);
//        NSLog(@"%ld", descoderArr.count);
        
        //  使用MJExtension, 字典数组转model数组, 灰常简单
        _arr = [TestMJExtension mj_keyValuesArrayWithObjectArray:result[@"ServiceList"]];
//        NSLog(@"%@", _arr[0]);
        
    }];
    
    
#pragma mark    - FMDB
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    databasePath = [documents stringByAppendingPathComponent:@"netData.sqlite"];
    
    db = [FMDatabase databaseWithPath:databasePath];
    NSLog(@"%@", NSHomeDirectory());
    
    
    
//    if ([db open]) {
//        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
//        BOOL res = [db executeUpdate:sqlCreateTable];
//        if (!res) {
//            NSLog(@"error when creating db table");
//        } else {
//            NSLog(@"success to creating db table");
//        }
//        [db close];
//        
//    }
    
    
}

- (NSString *)filePath {
    NSString *netDatapath = [NSString stringWithFormat:@"%@/netData.plist", NSHomeDirectory()];
    NSLog(@"netDatapath: %@", netDatapath);
    
    return netDatapath;
}

- (IBAction)createTable:(id)sender {
    if ([db open]) {
        NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
        BOOL res = [db executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
        [db close];
    }
    
    
}

- (IBAction)insertData:(id)sender {
    [db open];
    NSString *insertSql1 = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                            TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
    BOOL res1 = [db executeUpdate:insertSql1];
    NSString *insertSql2 = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                            TABLENAME, NAME, AGE, ADDRESS, @"李四", @"19", @"山东"];
    BOOL res2 = [db executeUpdate:insertSql2];
    if (!res1) {
        NSLog(@"insert error");
    } else {
        NSLog(@"insert success");
    }
    [db close];
    
}


- (IBAction)updateData:(id)sender {
    if ([db open]) {
        NSString *updateSql = [NSString stringWithFormat:
                               @"UPDATE '%@' SET '%@' = '%@' WHERE '%@' = '%@'",
                               TABLENAME,   AGE,  @"15" ,AGE,  @"13"];
        BOOL res = [db executeUpdate:updateSql];
        if (!res) {
            NSLog(@"error when update db table");
        } else {
            NSLog(@"success to update db table");
        }
        [db close];
        
    }
}

- (IBAction)deleteData:(id)sender {
    if ([db open]) {
        
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%@'",
                               TABLENAME, NAME, @"张三"];
        BOOL res = [db executeUpdate:deleteSql];
        
        if (!res) {
            NSLog(@"error when delete db table");
        } else {
            NSLog(@"success to delete db table");
        }
        [db close];
        
    }
}


- (IBAction)selectData:(id)sender {
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",TABLENAME];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            int Id = [rs intForColumn:ID];
            NSString * name = [rs stringForColumn:NAME];
            NSString * age = [rs stringForColumn:AGE];
            NSString * address = [rs stringForColumn:ADDRESS];
            NSLog(@"id = %d, name = %@, age = %@  address = %@", Id, name, age, address);
        }
        [db close];
    }
}


- (IBAction)multiThread:(id)sender {
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
    dispatch_queue_t q2 = dispatch_queue_create("queue2", NULL);
    
    dispatch_async(q1, ^{
        for (int i = 0; i < 50; ++i) {
            [queue inDatabase:^(FMDatabase *db2) {
                
                NSString *insertSql1= [NSString stringWithFormat:
                                       @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (?, ?, ?)",
                                       TABLENAME, NAME, AGE, ADDRESS];
                
                NSString * name = [NSString stringWithFormat:@"jack %d", i];
                NSString * age = [NSString stringWithFormat:@"%d", 10+i];
                
                
                BOOL res = [db2 executeUpdate:insertSql1, name, age,@"济南"];
                if (!res) {
                    NSLog(@"error to inster data: %@", name);
                } else {
                    NSLog(@"succ to inster data: %@", name);
                }
            }];
        }
    });
    
    dispatch_async(q2, ^{
        for (int i = 0; i < 50; ++i) {
            [queue inDatabase:^(FMDatabase *db2) {
                NSString *insertSql2= [NSString stringWithFormat:
                                       @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (?, ?, ?)",
                                       TABLENAME, NAME, AGE, ADDRESS];
                
                NSString * name = [NSString stringWithFormat:@"lilei %d", i];
                NSString * age = [NSString stringWithFormat:@"%d", 10+i];
                
                BOOL res = [db2 executeUpdate:insertSql2, name, age,@"北京"];
                if (!res) {
                    NSLog(@"error to inster data: %@", name);
                } else {
                    NSLog(@"succ to inster data: %@", name);
                }
            }];
        }
    });
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
