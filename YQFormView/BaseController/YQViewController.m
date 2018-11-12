//
//  YQViewController.m
//  YQFormView
//
//  Created by WYW on 2018/11/9.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "YQViewController.h"
#import "AppDelegate.h"

@interface YQViewController ()

@end

@implementation YQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = RGB(246, 246, 246);
    self.navigationController.navigationBar.translucent = NO;
    
    [self registerKeyboardNotification];
}

#pragma mark - addKeyboardNatification

- (void)registerKeyboardNotification
{
    if (!self.isListensKeyboard) {
        return;
    }
    self.keyboardDelegate = self; // 记得实现YWKeyboardDelegate协议
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

//当键盘弹出时调用
- (void)keyboardWillShow:(NSNotification *)notification
{
    [self keyboardChangeStatus:YQKeyBoardWillShow userInfo:notification.userInfo];
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)notification
{
    [self keyboardChangeStatus:YQKeyBoardWillHide userInfo:notification.userInfo];
}

// 得到动画时间、键盘高度等信息。并调用代理方法，在相应类里的代理方法里实现输入框上移下移动画等。
- (void)keyboardChangeStatus:(YQKeyBoardChangeType)changeType userInfo:(NSDictionary *)info
{
    CGFloat durationTime = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyboardHeight = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGRect beginFrame = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if([self.keyboardDelegate respondsToSelector:@selector(keyboardChangeStatus:beginFrame:endFrame:duration:keyboardHeight:userInfo:)])
    {
        [self.keyboardDelegate keyboardChangeStatus:changeType beginFrame:beginFrame endFrame:endFrame duration:durationTime keyboardHeight:keyboardHeight userInfo:info];
    }
}

#pragma mark - keyboard delegate
- (void)keyboardChangeStatus:(YQKeyBoardChangeType)changeType beginFrame:(CGRect)beginFrame endFrame:(CGRect)endFrame duration:(CGFloat)duration keyboardHeight:(CGFloat)kbHeight userInfo:(NSDictionary *)info
{
    // 具体由子类实现
}


// 一定要记得移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
