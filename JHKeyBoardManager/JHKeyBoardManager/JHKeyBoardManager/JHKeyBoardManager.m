//
//  JHKeyBoardManager.m
//  JHKeyBoardManager
//
//  Created by 黄俊煌 on 2017/8/23.
//  Copyright © 2017年 yunshi. All rights reserved.

#import "JHKeyBoardManager.h"
#import <UIKit/UIKit.h>

@interface JHKeyBoardManager ()

/** 唤出键盘的对象 UITextField、UITextView*/
@property (nonatomic, strong) id inputObject;
/** 键盘 notifivation*/
@property (nonatomic, strong) NSNotification *keyboardNotifivation;

@end

@implementation JHKeyBoardManager

+ (instancetype)sharedManager {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        // TextField开始编辑
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(textFieldTextDidBeginEditingNotification:) name:UITextFieldTextDidBeginEditingNotification
                                                   object:nil];
        // TextView开始编辑
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(textViewTextDidBeginEditingNotification:) name:UITextViewTextDidBeginEditingNotification
                                                   object:nil];
        // 键盘将要改变
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    });
    return instance;
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
    self.keyboardNotifivation = notification;
    if (!self.inputObject) { // 如果是UITextView它会先调用键盘的通知，再调用UITextView的通知
        return;
    }
    if ([self.inputObject isKindOfClass:[UITextView class]]) { // 弹出键盘时，如果是UITextView，要让（transformView方法）从UITextView的通知进去
        //获取键盘弹出后的Rect
        NSValue *keyBoardEndBounds=[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect  endRect=[keyBoardEndBounds CGRectValue];
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        if (endRect.origin.y != height) { // 并且不是退出键盘
            return;
        }
    }
    [self transformView:notification];
}

/// 偏移View
-(void)transformView:(NSNotification *)notification {
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    UIView *targetView;
    if ([self.inputObject isKindOfClass:[UIView class]]) {
        targetView = self.inputObject;
    }
    if (!targetView) {
        return;
    }
    
    UIViewController *vc = [self getCurrentVC];
    
    // targetView 在 toView 的 convertRect位置上的位置
    CGRect targetRect = [targetView convertRect:CGRectMake(0, 0, targetView.frame.size.width, targetView.frame.size.height) toView:vc.view];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat maxY = CGRectGetMaxY(targetRect);
    CGFloat cha = endRect.origin.y - maxY;
    
    if (maxY > endRect.origin.y) { // 键盘会挡住输入框
        
        if ([vc.view.subviews.firstObject isKindOfClass:[UIScrollView class]]) {// 如果self.view是UIScrollView，则滚动contentOffset
            UIScrollView *scrollView= vc.view.subviews.firstObject;
            //NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
            scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y + (-cha) + 10);
        }else {
            CGFloat interval = 0;
            if (cha < -10) {
                interval = 10;
            }
            [UIView animateWithDuration:0.25f animations:^{
                [vc.view setFrame:CGRectMake(vc.view.frame.origin.x, cha - interval, vc.view.frame.size.width, vc.view.frame.size.height)];
            }];
        }
    }
    if (endRect.origin.y == height) { //键盘回收 deltaY>100
        //NSLog(@"键盘回收");
        if ([vc.view.subviews.firstObject isKindOfClass:[UIScrollView class]]) {
            //UIScrollView *scrollView= self.view.subviews.firstObject;
            //NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
        }else {
            [UIView animateWithDuration:0.25f animations:^{
                [vc.view setFrame:CGRectMake(0, 0, vc.view.frame.size.width, vc.view.frame.size.height)];
            }];
            self.inputObject = nil;
            self.keyboardNotifivation = nil;
        }
    }
}

- (void)textFieldTextDidBeginEditingNotification:(NSNotification *)notification {
    //NSLog(@"textField ********** %@",notification.object);
    self.inputObject = notification.object;
}

- (void)textViewTextDidBeginEditingNotification:(NSNotification *)notification {
    //NSLog(@"textField =========== %@",notification.object);
    self.inputObject = notification.object;
    [self transformView:self.keyboardNotifivation];
}

/// 获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    //    if ([result isKindOfClass:[JTWrapViewController class]]) {
    //        result = [(JTWrapViewController *)result rootViewController];
    //    }
    return result;
}


@end
