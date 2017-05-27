//
//  ModuleManager.h
//  UnitsDemo
//
//  Created by guanglong on 2017/5/26.
//  Copyright © 2017年 bjhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleProtocols.h"

@interface ModuleManager : NSObject

+ (instancetype)shareManager;

- (void)registerClass:(Class)aCls forProtocol:(Protocol*)protocol;

// config 和 show 都可为 nil
// 如果 config 为 nil，则采用默认创建 module 对象，并采用默认配置
// 如果 show 为 nil，则采用默认方式展示（如果 module 是 controller 的话）
- (void)openProtocol:(Protocol*)protocol config:(void(^)(id module))config show:(void(^)(UIViewController* module))show;

// 如果 config 为 nil，则采用默认的配置和展示方式，同上面方法的 config 和 show 都传 nil
- (void)openProtocol:(Protocol *)protocol configClass:(void (^)(Class aCls))config;

- (Class)classForProtocol:(Protocol*)protocol;

@end


#import "UIView+PageSkip.h"
#import "NSObject+Router.h"
