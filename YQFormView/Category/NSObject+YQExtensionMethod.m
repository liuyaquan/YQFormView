//
//  NSObject+YQExtensionMethod.m
//  YQFormView
//
//  Created by WYW on 2018/11/12.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "NSObject+YQExtensionMethod.h"

#import <objc/runtime.h>

@implementation NSObject (YQExtensionMethod)

- (NSMutableArray *)yq_getAllProperties
{
    NSMutableArray * all_p = [NSMutableArray array];
    
    unsigned int a;
    
    objc_property_t * result = class_copyPropertyList([self class], &a);
    
    for (unsigned int i = 0; i < a; i++) {
        objc_property_t o_t =  result[i];
        [all_p addObject:[NSString stringWithFormat:@"%s", property_getName(o_t)]];
    }
    
    free(result);
    
    return all_p;
}

@end
