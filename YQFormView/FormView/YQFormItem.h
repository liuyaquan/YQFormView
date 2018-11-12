//
//  YQFormItem.h
//  dianshang
//
//  Created by haha on 2018/4/4.
//  Copyright © 2018年 yunjobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "YQFormViewConst.h"

@class YQFormView;

typedef NS_ENUM(NSUInteger, YQFormTextKeyboardType) {
    YQFormTextKeyboardDefault = 0, // 文本输入
    YQFormTextKeyboardNum = 1, // 纯数字键盘
    YQFormTextKeyboardPrice = 2, // 保留两位小数(价格键盘)
    YQFormTextKeyboardDecimal = 3, // 小数点键盘
};


typedef NS_ENUM(NSUInteger, YQFormType) {
    YQFormTypeTextField = 0, // 单行输入框
    YQFormTypeTextView = 1, // 多行输入框
    YQFormTypeButton = 2, // 按钮
    YQFormTypeSingle = 3, // 单选
    YQFormTypeDetail = 4, // 详情
};


@interface YQFormItem : NSObject

// 必填 根据key获取输入内容
@property (nonatomic, strong) NSString *key;
// 扩展属性
@property (nonatomic, strong) id ext;
// 表单类型
@property (nonatomic, assign) YQFormType type;
// 最大输入长度限制
@property (nonatomic, assign) NSInteger maxInputLength;
// 键盘类型
@property (nonatomic, assign) YQFormTextKeyboardType keyboardType;
// 校验出错时的提示信息
@property (nonatomic, strong) NSString *errText;

/***事件设置***/

// 执行事件
@property (nonatomic, strong) void(^operationBlock)(YQFormView *view);

/***UI设置***/

// 标题
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;

// 字体大小
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *textFont;

// 单选数组
@property (nonatomic, strong) NSArray *singles;

// 对齐方式
@property (nonatomic) NSTextAlignment textAlignment;

// 字体颜色
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *textColor;

// 提示文本
@property (nonatomic, strong) NSString *placeholder;

// 默认显示向下的图片
@property (nonatomic, strong) NSString *rightImage;

// 默认YES 禁止输入; NO 禁止
@property (nonatomic, assign) BOOL isEnableInput;

// 默认NO 其他文本与"*"对齐; NO 不对齐
@property (nonatomic, assign) BOOL isSpace;

// 默认NO 不显示必选"*"; YES 显示必选"*" 
@property (nonatomic, assign) BOOL isMust;

// 默认YES 线显示; NO 线不显示
@property (nonatomic, assign) BOOL isLine;

// 默认NO; YES 线变宽
@property (nonatomic, assign) BOOL isBigline;

+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title rightImage:(NSString *)rightImage;

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder rightImage:(NSString *)rightImage;

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder rightImage:(NSString *)rightImage isMust:(NSString *)isMust;

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder rightImage:(NSString *)rightImage isMust:(BOOL)isMust isSpace:(BOOL)isSpace;


@end
