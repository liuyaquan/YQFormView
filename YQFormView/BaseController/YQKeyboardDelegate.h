//
//  YQKeyboardDelegate.h
//  YQFormView
//
//  Created by WYW on 2018/11/9.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    YQKeyBoardWillShow,  // 键盘弹出
    YQKeyBoardWillHide, // 键盘退回
}YQKeyBoardChangeType;


@protocol YQKeyboardDelegate <NSObject>

- (void)keyboardChangeStatus:(YQKeyBoardChangeType)changeType
                  beginFrame:(CGRect)beginFrame
                    endFrame:(CGRect)endFrame
                    duration:(CGFloat)duration
              keyboardHeight:(CGFloat)kbHeight
                    userInfo:(NSDictionary *)info;

@end

