//
//  UserInfoEntity.h
//  YQFormView
//  网络获取的数据模型/上传数据模型
//  Created by WYW on 2018/11/9.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoEntity : NSObject

@property (nonatomic, strong) NSString *name;
/// 1 男  2 女
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *balance;

@property (nonatomic, strong) NSString *other;

- (NSString *)submitCheck:(NSArray*)dataArr;

@end
