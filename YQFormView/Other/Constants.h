//
//  Constants.h
//  MobileLuoYang
//  自定义的的常量
//  Created by csip on 15-1-15.
//  Copyright (c) 2015年 com.hn3l.mobilely. All rights reserved.
//

#ifndef MobileLuoYang_Constants_h
#define MobileLuoYang_Constants_h

/**
 * 随机色
 */
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define RGB(r, g, b) \
[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//屏幕宽高
#define APP_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define APP_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define APP_NAVH ([UIScreen mainScreen].bounds.size.height==812 ? 88 : 64)
#define APP_TABH ([UIScreen mainScreen].bounds.size.height==812 ? 83 : 49)
#define APP_BottomH ([UIScreen mainScreen].bounds.size.height==812 ? 34 : 0)

#pragma mark ---- UIImage  UIImageView  functions
#define IMG(name) [UIImage imageNamed:name]

#pragma mark ---- File  functions
#define STRING(str)         (str==[NSNull null]||str==nil)?@"":str


#endif

