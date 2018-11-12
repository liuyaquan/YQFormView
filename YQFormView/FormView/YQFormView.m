//
//  YQFormView.m
//  dianshang
//
//  Created by haha on 2018/4/4.
//  Copyright © 2018年 yunjobs. All rights reserved.
//

#import "YQFormView.h"

#import "UIView+Frame.h"
#import "NSObject+YQExtensionMethod.h"
#import "UITextView+ZWPlaceHolder.h"

@interface YQFormView()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UILabel *mustLbl;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *singleView;
@property (nonatomic, strong) UIButton *curSingleBtn;


@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic) id formModel;

@end

@implementation YQFormView


- (UILabel *)mustLbl
{
    if (_mustLbl == nil) {
        UILabel *alabel = [[UILabel alloc] init];
        alabel.text = @"*";
        alabel.textColor = [UIColor redColor];
        alabel.font = [UIFont systemFontOfSize:20];
        alabel.textAlignment = NSTextAlignmentRight;
        _mustLbl = alabel;
    }
    return _mustLbl;
}
- (UILabel *)detailLbl
{
    if (_detailLbl == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.item.detail;
        label.textColor = FVTextColor;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.backgroundColor = RandomColor;
        _detailLbl = label;
    }
    return _detailLbl;
}
- (UILabel *)titleLbl
{
    if (_titleLbl == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.item.title;
        label.textColor = self.item.titleColor;
        label.font = self.item.titleFont;
        [label sizeToFit];
        _titleLbl = label;
    }
    return _titleLbl;
}

- (UITextField *)textField
{
    if (_textField == nil) {
        UITextField *textField = [[UITextField alloc] init];
        textField.textColor = self.item.textColor;
        textField.font = self.item.textFont;
        textField.placeholder = self.item.placeholder;
        textField.textAlignment = self.item.textAlignment;
        //textField.text = self.item.text;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.delegate = self;
        _textField = textField;
        // 添加文本改变监听
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIImageView *)rightImg
{
    if (_rightImg == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:self.item.rightImage];
        _rightImg = imageV;
    }
    return _rightImg;
}

- (UIButton *)button
{
    if (_button == nil) {
        UIButton *button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, self.yq_width, self.yq_height);
        _button = button;
    }
    return _button;
}

- (UITextView *)textView
{
    if (_textView == nil) {
        UITextView *textV = [[UITextView alloc] init];
        //textV.backgroundColor = RandomColor;
        textV.font = [UIFont systemFontOfSize:16];
        textV.placeholder = self.item.placeholder;
        textV.textColor = FVTextColor;
        textV.delegate = self;
        _textView = textV;
    }
    return _textView;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = FVLineColor;
        _lineView = lineView;
    }
    return _lineView;
}

- (void)setSingleBtn:(NSInteger)singleBtn
{
    _singleBtn = singleBtn;
    
    self.curSingleBtn.selected = NO;
    
    UIButton *button = [self.singleView viewWithTag:singleBtn];
    if ([button isKindOfClass:[UIButton class]]) {
        button.selected = YES;
        self.curSingleBtn = button;
    }
}

- (NSInteger)singleIndex
{
    if (self.curSingleBtn == nil) {
        return -1;
    }
    return self.curSingleBtn.tag;
}

- (void)refreshView:(YQFormItem *)item formModel:(id)formModel
{
    _formModel = formModel;
    
    if ([self checkKey:self.item.key]) {
    
        if (item.type == YQFormTypeTextField || item.type == YQFormTypeButton) {
            self.textField.text = [formModel valueForKey:item.key]; // 将_formModel的值以KVC的方式赋给textField
        }else if (item.type == YQFormTypeTextView){
            self.textView.text = [formModel valueForKey:item.key]; // 将_formModel的值以KVC的方式赋给textField
        }else if (item.type == YQFormTypeSingle){
            self.singleBtn = [[formModel valueForKey:item.key] integerValue];
        }
    
    }
}

- (void)setItem:(YQFormItem *)item
{
    _item = item;
 
    self.backgroundColor = [UIColor whiteColor];
    CGFloat remainderH = self.yq_height - FVDefaultHeight;
    if (remainderH > 0) {
        self.yq_height = FVDefaultHeight;
    }
    
    CGFloat left = FVDefaultMarginLeft;
    // 添加空格对齐
    if (item.isSpace) {
        left = FVDefaultMarginLeft+10;
    }
    // 添加必选"*"
    if (item.isMust) {
        self.mustLbl.frame = CGRectMake(15, 0, 10, self.yq_height);
        [self addSubview:self.mustLbl];
        left = self.mustLbl.yq_right;
    }
    // 添加标题
    self.titleLbl.frame = CGRectMake(left, 0, self.titleLbl.yq_width, self.yq_height);
    [self addSubview:self.titleLbl];
    if (item.type==YQFormTypeTextField || item.type==YQFormTypeSingle || item.type==YQFormTypeTextView){
        item.rightImage=@"";
    }
    // 添加右边图片
    CGFloat right = 15;
    if (item.rightImage.length > 0) {
        self.rightImg.frame = CGRectMake(self.yq_width-35, (self.yq_height-20)*0.5, 20, 20);
        [self addSubview:self.rightImg];
        right = 15+20;
    }
    
    if (item.type == YQFormTypeTextField) {
        // 添加单行输入框
        self.textField.frame = CGRectMake(self.titleLbl.yq_right+5, (self.yq_height-32)*0.5, self.yq_width-self.titleLbl.yq_right-10-right, 32);
        [self addSubview:self.textField];
    }else if (item.type == YQFormTypeButton){
        // 添加单行输入框
        self.textField.frame = CGRectMake(self.titleLbl.yq_right+5, (self.yq_height-32)*0.5, self.yq_width-self.titleLbl.yq_right-10-right, 32);
        [self addSubview:self.textField];
        self.textField.enabled = NO;
        
        // 添加按钮
        [self addSubview:self.button];
        
    }else if (item.type == YQFormTypeTextView){
        // 添加多行输入框
        [self addTextVConstraint:self.textView toView:self];
    }else if (item.type == YQFormTypeDetail){
        // 添加按钮
        [self addSubview:self.button];
        if (item.detail.length > 0) {
            [self addTextVConstraint:self.detailLbl toView:self];
        }
    }else if (item.type == YQFormTypeSingle){
//        UIView *singleView = [[UIView alloc] initWithFrame:CGRectMake(self.titleLbl.yq_right+5, 0, self.yq_width-self.titleLbl.yq_right-10-right, self.yq_height)];
        
        NSInteger count = item.singles.count+1;
        
        UIView *singleView = [[UIView alloc] initWithFrame:CGRectMake(self.yq_width/count*1, 0, self.yq_width/count*(count-1), self.yq_height)];
        [self addSubview:singleView];
        self.singleView = singleView;
        
        NSArray *array = item.singles;
        CGFloat buttonh = 40;
        CGFloat btnRight = 10;
        for (int i = 0; i < array.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnRight, 5, 0, buttonh)];
            button.tag = i+1;
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:FVTextColor forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"select_un"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(singleClick:) forControlEvents:UIControlEventTouchUpInside];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [button sizeToFit];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            if (count>3) {
                button.yq_width += 10;
            }else{
                button.yq_width += 30;
            }
            button.yq_height = buttonh;
            [singleView addSubview:button];
            btnRight = button.yq_right+10;
//            if (i == 0) {
//                button.selected = YES;
//                self.curSingleBtn = button;
//            }
        }
    }
    
    if (item.isLine) {
        if (item.isBigline) {
            self.lineView.frame = CGRectMake(0, self.yq_height-10, self.yq_width, 10);
            self.lineView.backgroundColor = FVBigLineColor;
        }else{
            self.lineView.frame = CGRectMake(15, self.yq_height-1, self.yq_width-30, 0.5);
        }
        [self addSubConstraint:self.lineView toView:self];
    }
    self.yq_height += remainderH;
    
    // 禁止输入
    self.textField.enabled = item.isEnableInput;
    self.textView.userInteractionEnabled = item.isEnableInput;
    
    // 配置键盘类型
    [self configKeyboardType:item.keyboardType];
}

- (void)configKeyboardType:(YQFormTextKeyboardType)type
{
    self.textField.keyboardType = UIKeyboardTypeDefault;
    if (type == YQFormTextKeyboardNum) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }else if (type == YQFormTextKeyboardPrice || type == YQFormTextKeyboardDecimal){
        self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
}

// 输入框文本 监听事件
- (void)textFieldDidChange:(UITextView *)textField
{
    if ([self checkKey:self.item.key]) {
        // 文本改变后实时修改 对应数据
        [self.formModel setValue:textField.text forKey:self.item.key]; // 将textField中的值赋给_formModel
    }
    
    NSString *toBeString = textField.text;
    NSString *lang = textField.textInputMode.primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) // 如果输入中文
    {
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的汉字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > self.item.maxInputLength) {
                textField.text = [toBeString substringToIndex:self.item.maxInputLength];
            }
        }
        // 对高亮文本不做限制，因为它不是最终显示在输入框的文本。
        else
        {
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > self.item.maxInputLength) {
            textField.text = [toBeString substringToIndex:self.item.maxInputLength];
        }
    }
    
}
// YQFormTextKeyboardPrice 价格键盘限制小数点两位数
NSInteger countaaa = 10;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == self.textField && self.item.keyboardType == YQFormTextKeyboardPrice){
        if ([string isEqualToString:@""]) {
            return YES;
        }
        
        NSRange range = [textField.text rangeOfString:@"."];
        if (range.length>=1) {
            countaaa = range.location+2;
            if ([textField.text length] > countaaa) {
                return NO;
            }
        }
        if ([string isEqualToString:@"."]) {
            if ([textField.text length]==0) {
                return NO;
            }
            NSString *string2 = [textField.text substringWithRange:NSMakeRange([textField.text length]-1, 1)];
            if ([string isEqualToString:string2]) {
                return NO;
            }
            NSRange range = [textField.text rangeOfString:@"."];
            if (range.length>=1) {
                return NO;
            }
            countaaa = [textField.text length]+1;
        }
        if ([textField.text length] > 7) {
            return NO;
        }
        
        return YES;
    }
    //    else if (textField == payPassTxt){
    //        if ([string isEqualToString:@""]) {
    //            return YES;
    //        }
    //        if ([textField.text length] < 6) {
    //            return YES;
    //        }else{
    //            return NO;
    //        }
    //    }
    return YES;
}


- (void)singleClick:(UIButton *)sender
{
    if ([self checkKey:self.item.key]) {
        // 实时修改 用户勾选数据
        [self.formModel setValue:@(sender.tag) forKey:self.item.key]; // 将textField中的值赋给_formModel
    }
    
    if ([sender isEqual:self.curSingleBtn]) {
        //sender.selected = !sender.selected;
        self.curSingleBtn = sender;
    }else{
        sender.selected = YES;
        self.curSingleBtn.selected = NO;
        self.curSingleBtn = sender;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(formSingleBtnClick:button:)]) {
        [self.delegate formSingleBtnClick:self button:sender];
    }
}

- (void)buttonClick:(UIButton *)sender
{
    if (self.item.operationBlock) {
        self.item.operationBlock(self);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(formTextBeginEdit:)]) {
        [self.delegate formTextBeginEdit:self];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(formTextBeginEdit:)]) {
        [self.delegate formTextBeginEdit:self];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self checkKey:self.item.key]) {
        // 实时修改 用户输入数据
        [self.formModel setValue:textView.text forKey:self.item.key]; // 将textField中的值赋给_formModel
    }
    
    NSString *toBeString = textView.text;
    NSString *lang = textView.textInputMode.primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) // 如果输入中文
    {
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的汉字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > self.item.maxInputLength) {
                textView.text = [toBeString substringToIndex:self.item.maxInputLength];
            }
        }
        // 对高亮文本不做限制，因为它不是最终显示在输入框的文本。
        else
        {
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > self.item.maxInputLength) {
            textView.text = [toBeString substringToIndex:self.item.maxInputLength];
        }
    }
}

- (BOOL)checkKey:(NSString *)key
{
    NSMutableArray *array = [self.formModel yq_getAllProperties];
    if ([array containsObject:key]) {
        return YES;
    }else{
        FVLog(@"需要在%@添加%@属性",NSStringFromClass([self.formModel class]),key);
        return NO;
    }
    return NO;
}


+ (CGFloat)viewHeight:(YQFormItem *)item
{
    CGFloat h = FVDefaultHeight;
    if (item.isBigline) {
        h += FVDefaultBigLineHeight;
    }else if (item.type == YQFormTypeTextView) {
        h += FVDefaultTextViewHeight;
    }
    
    return h;
}

- (void)addTextVConstraint:(UIView *)view toView:(UIView *)cell
{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [cell addSubview:view];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-20]];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15]];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15]];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:40]];
}

- (void)addSubConstraint:(UIView *)view toView:(UIView *)cell
{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [cell addSubview:view];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:view.yq_x]];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:-view.yq_x]];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:view.yq_height]];
}

@end
