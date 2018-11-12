//
//  UserInfoEntity.m
//  YQFormView
//
//  Created by WYW on 2018/11/9.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "UserInfoEntity.h"

#import "YQFormView.h"

@implementation UserInfoEntity


- (NSString *)submitCheck:(NSArray*)dataArr;
{
    NSString *error = nil;
    if(self.name.length == 0){
        if (dataArr.count > 0) {
            error = @"姓名不能为空";
            YQFormView *view = dataArr[0];
            view.item.errText = error;
        }
        return error;
    }
    
    if(self.name.length > 8){
        if (dataArr.count > 0) {
            error = @"最多8个字";
            YQFormView *view = dataArr[0];
            view.item.errText = error;
        }
        return error;
    }
    
    if(self.sex == 0){
        if (dataArr.count > 1) {
            error = @"请选择性别";
            YQFormView *view = dataArr[1];
            view.item.errText = error;
        }
        return error;
    }
    
    return error;
}
@end
