//
//  OtherViewController.m
//  YQFormView
//
//  Created by WYW on 2018/11/12.
//  Copyright © 2018年 ITCoderW. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)dataClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.callBack) {
        self.callBack(sender.currentTitle);
    }
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
