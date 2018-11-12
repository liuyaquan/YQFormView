//
//  YQViewController.h
//  YQFormView
//
//  Created by WYW on 2018/11/9.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQKeyboardDelegate.h"

@interface YQViewController : UIViewController<YQKeyboardDelegate>

@property (nonatomic, assign) BOOL isListensKeyboard;

@property (nonatomic, weak) id<YQKeyboardDelegate> keyboardDelegate;  // 代理

- (void)hideKeyboard;


@end
