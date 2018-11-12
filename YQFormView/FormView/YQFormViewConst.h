//
//  YQFormViewConst.h
//  YQFormView
//  常量
//  Created by WYW on 2018/11/9.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <UIKit/UIKit.h>

// 弱引用
#define FVWeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define FVLog(...) NSLog(__VA_ARGS__)
#else
#define FVLog(...)
#endif

// RGB颜色
#define FVColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define FVTitleColor FVColor(102, 102, 102)
#define FVTextColor FVColor(51, 51, 51)

#define FVLineColor FVColor(229, 229, 229)
#define FVBigLineColor FVColor(246, 246, 246)

// 字体大小
#define FVTitleFont [UIFont systemFontOfSize:16]
#define FVTextFont [UIFont systemFontOfSize:16]

// 箭头图片
#define FVArrowDownImage @"arrow_down"
#define FVArrowRightImage @"arrow_right"

// 常量
UIKIT_EXTERN const CGFloat FVDefaultHeight;
UIKIT_EXTERN const CGFloat FVDefaultBigLineHeight;
UIKIT_EXTERN const CGFloat FVDefaultMarginLeft;
UIKIT_EXTERN const CGFloat FVDefaultTextViewHeight;

