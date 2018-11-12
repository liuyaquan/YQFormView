//
//  OtherViewController.h
//  YQFormView
//
//  Created by WYW on 2018/11/12.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherViewController : UIViewController

@property (nonatomic, copy) void(^callBack)(NSString *data);

@end
