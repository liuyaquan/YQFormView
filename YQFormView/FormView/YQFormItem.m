//
//  YQFormItem.m
//  dianshang
//
//  Created by haha on 2018/4/4.
//  Copyright © 2018年 yunjobs. All rights reserved.
//


#import "YQFormItem.h"


@implementation YQFormItem

+ (instancetype)itemWithTitle:(NSString *)title
{
    YQFormItem *item = [[YQFormItem alloc] init];
    [item defaultSetting];
    item.title = title;
    
    return item;
}

- (void)defaultSetting
{
    self.maxInputLength = 99999;
    self.key = @"";
    self.title = @"";
    self.rightImage = FVArrowDownImage;
    self.type = YQFormTypeTextField;
    self.textAlignment = NSTextAlignmentRight;
    self.textFont = FVTextFont;
    self.titleFont = FVTitleFont;
    self.titleColor = FVTitleColor;
    self.textColor = FVTextColor;
    self.isSpace = NO;
    self.isMust = NO;
    self.isLine = YES;
    self.isBigline = NO;
    self.isEnableInput = YES;
}

+ (instancetype)itemWithTitle:(NSString *)title rightImage:(NSString *)rightImage
{
    YQFormItem *item = [[YQFormItem alloc] init];
    [item defaultSetting];
    item.title = title;
    item.rightImage = rightImage;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder
{
    YQFormItem *item = [[YQFormItem alloc] init];
    [item defaultSetting];
    item.title = title;
    item.placeholder = placeholder;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder rightImage:(NSString *)rightImage
{
    YQFormItem *item = [[YQFormItem alloc] init];
    [item defaultSetting];
    item.title = title;
    item.placeholder = placeholder;
    item.rightImage = rightImage;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder rightImage:(NSString *)rightImage isMust:(NSString *)isMust
{
    YQFormItem *item = [[YQFormItem alloc] init];
    [item defaultSetting];
    item.title = title;
    item.placeholder = placeholder;
    item.rightImage = rightImage;
    item.isMust = isMust;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder rightImage:(NSString *)rightImage isMust:(BOOL)isMust isSpace:(BOOL)isSpace
{
    YQFormItem *item = [[YQFormItem alloc] init];
    [item defaultSetting];
    item.title = title;
    item.placeholder = placeholder;
    item.rightImage = rightImage;
    item.isMust = isMust;
    item.isSpace = isSpace;
    
    return item;
}

@end
