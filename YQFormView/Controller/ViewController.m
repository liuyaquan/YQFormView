//
//  ViewController.m
//  YQFormView
//
//  Created by WYW on 2018/11/9.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "ViewController.h"

#import "OtherViewController.h"

#import "YQFormView.h"
#import "YQBrithDayView.h"
#import "UIView+Frame.h"
#import "UserInfoEntity.h"
#import <MJExtension/MJExtension.h>

@interface ViewController ()<YQFormViewDelegate,UIScrollViewDelegate>
{
    CGFloat _offsetY;
}

@property (nonatomic, strong) UIScrollView *formScrollView;

@property (nonatomic, strong) NSMutableArray *dataSoures;
@property (nonatomic, strong) NSMutableArray *formViews;

@property (nonatomic, strong) UserInfoEntity *userInfo;

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.isListensKeyboard = YES;
    
    [super viewDidLoad];
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(submit:)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    [self initDataSource];
    
    [self initView];
    
    [self refreshData];
}
- (void)refreshData
{
    UserInfoEntity *info = [[UserInfoEntity alloc] init];
    info.name = @"小红";
    info.sex = 2;
    info.birthday = @"2018-09-08";
    info.address = @"地址地址地址地址地址地址地址地址地址地址地址地址";
    info.mobile = @"17899993333";
    info.balance = @"0.01";
    self.userInfo = info;
    
    for (YQFormView *view in self.formViews) {
        [view refreshView:view.item formModel:info];
    }
}

- (void)initView
{
    self.formViews = [NSMutableArray array];
    
    CGFloat bottomy = 0;
    
    for (YQFormItem *item in self.dataSoures) {
        CGFloat viewH = [YQFormView viewHeight:item];
        YQFormView *view = [[YQFormView alloc] initWithFrame:CGRectMake(0, bottomy, APP_WIDTH, viewH)];
        view.item = item;
        view.delegate = self;
        [self.formScrollView addSubview:view];
        bottomy = view.yq_bottom;
        [self.formViews addObject:view];
    }
    
    [self.formScrollView setContentSize:CGSizeMake(APP_WIDTH, bottomy)];
}
- (void)initDataSource
{
    self.dataSoures = [NSMutableArray array];
    
    
    YQFormItem *nameItem = [YQFormItem itemWithTitle:@"联系人:"];
    nameItem.type = YQFormTypeTextField;
    nameItem.maxInputLength = 10;
    nameItem.key = @"name";// key 和 UserInfoEntity 对应
    nameItem.placeholder = @"请输入";
    nameItem.isSpace = YES;
    nameItem.isMust = YES;
    [self.dataSoures addObject:nameItem];
    
    YQFormItem *mobileItem = [YQFormItem itemWithTitle:@"手机号:"];
    mobileItem.type = YQFormTypeTextField;
    mobileItem.keyboardType = YQFormTextKeyboardNum;
    mobileItem.key = @"mobile";// key 和 UserInfoEntity 对应
    mobileItem.placeholder = @"请输入";
    mobileItem.isSpace = YES;
    [self.dataSoures addObject:mobileItem];
    
    YQFormItem *balanceItem = [YQFormItem itemWithTitle:@"余额:"];
    balanceItem.type = YQFormTypeTextField;
    balanceItem.keyboardType = YQFormTextKeyboardPrice;
    balanceItem.key = @"balance";// key 和 UserInfoEntity 对应
    balanceItem.placeholder = @"请输入";
    balanceItem.isEnableInput = NO;
    balanceItem.isSpace = YES;
    [self.dataSoures addObject:balanceItem];
    
    YQFormItem *sexItem = [YQFormItem itemWithTitle:@"性别:"];
    sexItem.type = YQFormTypeSingle;
    sexItem.key = @"sex";// key 和 UserInfoEntity 对应
    sexItem.singles = @[@"男",@"女"];
    sexItem.isSpace = YES;
    sexItem.isBigline = YES;
    sexItem.isMust = YES;
    [self.dataSoures addObject:sexItem];
    
    YQFormItem *birthdayItem = [YQFormItem itemWithTitle:@"生日:"];
    birthdayItem.type = YQFormTypeButton;
    FVWeakSelf;
    birthdayItem.operationBlock = ^(YQFormView *view) {
        [weakSelf birthdaySelect:view];
    };
    birthdayItem.key = @"birthday";// key 和 UserInfoEntity 对应
    birthdayItem.placeholder = @"请选择";
    birthdayItem.isSpace = YES;
    [self.dataSoures addObject:birthdayItem];
    
    YQFormItem *addressItem = [YQFormItem itemWithTitle:@"地址:"];
    addressItem.maxInputLength = 25;
    addressItem.type = YQFormTypeTextView;
    addressItem.key = @"address";// key 和 UserInfoEntity 对应
    addressItem.placeholder = @"请输入地址";
    addressItem.isSpace = YES;
    [self.dataSoures addObject:addressItem];
    
    YQFormItem *otherItem = [YQFormItem itemWithTitle:@"Other:"];
    otherItem.rightImage = FVArrowRightImage;
    otherItem.type = YQFormTypeButton;
    otherItem.operationBlock = ^(YQFormView *view) {
        [weakSelf otherSelect:view];
    };
    otherItem.key = @"other";// key 和 UserInfoEntity 对应
    otherItem.placeholder = @"请选择";
    otherItem.isSpace = YES;
    [self.dataSoures addObject:otherItem];
}

#pragma mark - event reponse

- (void)otherSelect:(YQFormView *)view
{
    // 选择
    FVWeakSelf;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OtherViewController *otherVC = [storyboard instantiateViewControllerWithIdentifier:@"OtherViewController"];
    otherVC.callBack = ^(NSString *data) {
        weakSelf.userInfo.other = data;
        [view refreshView:view.item formModel:self.userInfo];
    };
    [self.navigationController pushViewController:otherVC animated:YES];
}

- (void)birthdaySelect:(YQFormView *)view
{
    [self hideKeyboard];
    
    // 选择生日
    YQBrithDayView *brithView = [[YQBrithDayView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH,APP_HEIGHT)];
    brithView.isLimit = YES;
    [brithView showAnimate];
    
    FVWeakSelf;
    brithView.submitBlock = ^(NSString *dateStr) {
        weakSelf.userInfo.birthday = dateStr;
        [view refreshView:view.item formModel:weakSelf.userInfo];
    };
}

- (void)submit:(id)sender
{
    [self hideKeyboard];
    
    NSString *error = [self.userInfo submitCheck:self.formViews];
    if (error != nil) {
        [self alertMsg:error];
    }else{
        NSString *msg = [self.userInfo mj_JSONString];
        [self alertMsg:msg title:@"Params are OK"];
    }
}
/// 弹窗
- (void)alertMsg:(NSString *)msg {
    [self alertMsg:nil title:msg];
}
- (void)alertMsg:(NSString *)msg title:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:done];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - YQFormViewDelegate

- (void)formTextBeginEdit:(YQFormView *)view
{
    _offsetY = view.yq_bottom;
}

#pragma mark - keyboard delegate

- (void)keyboardChangeStatus:(YQKeyBoardChangeType)changeType beginFrame:(CGRect)beginFrame endFrame:(CGRect)endFrame duration:(CGFloat)duration keyboardHeight:(CGFloat)kbHeight userInfo:(NSDictionary *)info
{
    if(changeType == YQKeyBoardWillShow)
    {
        CGFloat curOffset = _offsetY - _formScrollView.contentOffset.y;
        CGFloat offset = (APP_HEIGHT-APP_NAVH-kbHeight) - curOffset;
        if (offset < 0) {
            [UIView animateWithDuration:duration animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(0, offset);
            }];
        }
    }
    else if(changeType == YQKeyBoardWillHide)
    {
        [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformIdentity;
        }];
    }
}

- (UIScrollView *)formScrollView
{
    if (_formScrollView == nil) {
        _formScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT-APP_NAVH-APP_BottomH)];
        [_formScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
        _formScrollView.delegate = self;
        [self.view addSubview:_formScrollView];
    }
    return _formScrollView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideKeyboard];
}

- (void)tapClick
{
    [self hideKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
