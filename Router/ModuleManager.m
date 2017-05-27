//
//  ModuleManager.m
//  UnitsDemo
//
//  Created by guanglong on 2017/5/26.
//  Copyright © 2017年 bjhl. All rights reserved.
//

#import "ModuleManager.h"

@interface ModuleManager ()

@property (nonatomic, strong) NSMutableDictionary* classProtocolMap;

@end

@implementation ModuleManager

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)shareManager
{
    static ModuleManager* sModuleManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sModuleManager = [[self alloc] init];
    });
    return sModuleManager;
}

- (void)registerClass:(Class)aCls forProtocol:(Protocol *)protocol
{
    [self.classProtocolMap setValue:aCls forKey:NSStringFromProtocol(protocol)];
}

- (void)openProtocol:(Protocol *)protocol config:(void (^)(id))config show:(void (^)(UIViewController *))show
{
    Class aCls = [self classForProtocol:protocol];
    if (aCls) {
        id module = [[aCls alloc] init];
        if (config) {
            config(module);
        }
        
        if ([module isKindOfClass:[UIViewController class]]) {
            if (show) {
                show(module);
            }
            else {
                UIViewController* moduleController = (UIViewController*)module;
                [moduleController xtt_showAnimated:YES];
            }
        }
        else {
            NSLog(@"module <%@> is not a viewController", module);
        }
    }
    else {
        NSLog(@"class for protocol <%@> is not registered.", protocol);
    }
}

- (void)openProtocol:(Protocol *)protocol configClass:(void (^)(__unsafe_unretained Class))config
{
    Class aCls = [self classForProtocol:protocol];
    if (aCls) {
        if (config) {
            config(aCls);
        }
        else {
            [self openProtocol:protocol config:nil show:nil];
        }
    }
    else {
        NSLog(@"class for protocol <%@> is not registered.", protocol);
    }
}

- (Class)classForProtocol:(Protocol *)protocol
{
    Class aCls = [self.classProtocolMap valueForKey:NSStringFromProtocol(protocol)];
    return aCls;
}

- (NSMutableDictionary *)classProtocolMap
{
    if (!_classProtocolMap) {
        _classProtocolMap = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _classProtocolMap;
}

@end
