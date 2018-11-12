//
//  YQBrithDayView.h
//  dianshang
//
//  Created by yunjobs on 2017/9/21.
//  Copyright © 2017年 yunjobs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BrithDayBlock)(NSString *dateStr);

@interface YQBrithDayView : UIView

- (instancetype)initWithFrame:(CGRect)frame isSofor:(BOOL)isSofor;

// 是否需要限制日期
@property (nonatomic, assign) BOOL isLimit;

@property (nonatomic, strong) BrithDayBlock dateBlock;

// 确定的时候执行
@property (nonatomic, strong) BrithDayBlock submitBlock;

- (void)showAnimate;

// 限制日期
- (void)setMaxDate:(NSDate *)date;
- (void)setMinDate:(NSDate *)date;

@end
