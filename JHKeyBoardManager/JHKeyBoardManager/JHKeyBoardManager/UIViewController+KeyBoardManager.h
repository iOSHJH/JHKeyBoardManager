//
//  UIViewController+KeyBoardManager.h
//  JHKeyBoardManager
//
//  Created by 黄俊煌 on 2017/8/24.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KeyBoardManager)

/** 唤出键盘的对象 UITextField、UITextView*/
@property (nonatomic, strong) id inputObject;
/** 键盘 notifivation*/
@property (nonatomic, strong) NSNotification *keyboardNotifivation;

/** 当前控制器的view跟随键盘起伏，妈妈再也不用担心键盘挡住输入框了*/
- (void)transformViewForKeyboard;

@end
