//
//  JHKeyBoardManager.h
//  JHKeyBoardManager
//
//  Created by 黄俊煌 on 2017/8/23.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    键盘管理器：当前控制器的view跟随键盘起伏，妈妈再也不用担心键盘挡住输入框了
 */

@interface JHKeyBoardManager : NSObject

+ (instancetype)sharedManager;

@end
