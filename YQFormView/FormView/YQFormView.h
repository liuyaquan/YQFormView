//
//  YQFormView.h
//  dianshang
//
//  Created by haha on 2018/4/4.
//  Copyright © 2018年 yunjobs. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "YQFormItem.h"


@class YQFormView;

@protocol YQFormViewDelegate <NSObject>

@optional

- (void)formTextBeginEdit:(YQFormView *)view;

- (void)formSingleBtnClick:(YQFormView *)view button:(UIButton *)sender;

@end


@interface YQFormView : UIView

@property (nonatomic, weak) id<YQFormViewDelegate> delegate;

@property (nonatomic, strong) YQFormItem *item;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UILabel *detailLbl;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UITextView *textView;

// 设置默认单选
@property (nonatomic, assign) NSInteger singleBtn;
// 选择索引
@property (nonatomic, assign) NSInteger singleIndex;


@property (nonatomic, strong) id selectObject;

// 计算高度
+ (CGFloat)viewHeight:(YQFormItem *)item;

// 刷新数据
- (void)refreshView:(YQFormItem *)item formModel:(id)formModel;

@end



