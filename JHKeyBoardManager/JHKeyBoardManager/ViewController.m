//
//  ViewController.m
//  JHKeyBoardManager
//
//  Created by 黄俊煌 on 2017/8/23.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "ViewController.h"
#import "TwoVC.h"
//#import "UIViewController+KeyBoardManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self transformViewForKeyboard];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

- (IBAction)buttonAction:(id)sender {
    
    [self.navigationController pushViewController:[TwoVC new] animated:YES];
}


@end
