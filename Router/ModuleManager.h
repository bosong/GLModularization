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
- (void)openProtocol:(Protocol*)protocol config:(void(^)(id module))config show:(void(^)(UIViewController* module))show;

@end


#import "UIView+PageSkip.h"
#import "NSObject+Router.h"
