//
//  ThreeVC.m
//  JHKeyBoardManager
//
//  Created by 黄俊煌 on 2017/8/28.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "ThreeVC.h"
//#import "UIViewController+KeyBoardManager.h"

@interface ThreeVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self transformViewForKeyboard];
    
    [self.view addSubview:self.scrollView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    textField.backgroundColor = [UIColor brownColor];
    [self.scrollView addSubview:textField];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 200, 200, 100)];
    textView.backgroundColor = [UIColor brownColor];
    [self.scrollView addSubview:textView];
    
    
    UITextView *textView1 = [[UITextView alloc] initWithFrame:CGRectMake(50, 500, 200, 200)];
    textView1.backgroundColor = [UIColor brownColor];
    [self.scrollView addSubview:textView1];
    self.textView = textView1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

- (UIScrollView *)scrollView {
    if (_scrollView) return _scrollView;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
    //_scrollView.showsVerticalScrollIndicator = NO;
    return _scrollView;
}

@end
