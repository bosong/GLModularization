//
//  UNRouter.h
//  UnitsDemo
//
//  Created by guanglong on 2017/5/25.
//  Copyright © 2017年 bjhl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef UIViewController*(^UNRegisterUrlHandler)(NSDictionary* queryParams, id extParams);

@interface UNRouter : NSObject

+ (instancetype)shareRouter;

- (void)registerUrl:(NSString*)url handler:(UNRegisterUrlHandler)handler;

- (void)openUrl:(NSString*)url extParams:(id)extParams show:(void(^)(UIViewController* vc))show;

- (UIViewController*)controllerFromUrl:(NSString*)url extParams:(id)extParams;

@end

#import "UIView+PageSkip.h"
#import "NSObject+Router.h"
