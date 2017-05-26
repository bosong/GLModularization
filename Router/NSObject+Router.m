//
//  NSObject+Router.m
//  Pods
//
//  Created by guanglong on 2017/5/25.
//
//

#import "NSObject+Router.h"

@implementation NSObject (Router)

+ (void)router_registerUrl:(NSString *)url handler:(UNRegisterUrlHandler)handler
{
    [[UNRouter shareRouter] registerUrl:url handler:handler];
}

- (void)router_registerUrl:(NSString *)url handler:(UNRegisterUrlHandler)handler
{
    [self.class router_registerUrl:url handler:handler];
}

- (void)router_openUrl:(NSString *)url extParams:(id)extParams show:(void (^)(UIViewController *))show
{
    [[UNRouter shareRouter] openUrl:url extParams:extParams show:show];
}

- (void)router_showUrl:(NSString *)url extParams:(id)extParams animated:(BOOL)animated
{
    UIViewController* vc = [[UNRouter shareRouter] controllerFromUrl:url extParams:extParams];
    if (vc) {
        [vc xtt_showAnimated:animated];
    }
}

- (void)router_pushUrl:(NSString *)url extParams:(id)extParams animated:(BOOL)animated
{
    UIViewController* vc = [[UNRouter shareRouter] controllerFromUrl:url extParams:extParams];
    if (vc) {
        if ([self isKindOfClass:[UIView class]] || [self isKindOfClass:[UIViewController class]]) {
            UIView* selfView = (UIView*)self;
            [selfView xtt_pushViewController:vc animated:animated];
        }
        else {
            [vc xtt_showAnimated:animated];
        }
    }
}

- (void)router_presentUrl:(NSString *)url extParams:(id)extParams animated:(BOOL)animated
{
    UIViewController* vc = [[UNRouter shareRouter] controllerFromUrl:url extParams:extParams];
    if (vc) {
        if ([self isKindOfClass:[UIView class]] || [self isKindOfClass:[UIViewController class]]) {
            UIView* selfView = (UIView*)self;
            [selfView xtt_presentViewController:vc animated:animated];
        }
        else {
            [vc xtt_showAnimated:animated];
        }
    }
}

#pragma mark - - protocol 
+ (void)proto_registerClass:(Class)aCls forProtocol:(Protocol*)protocol
{
    [[ModuleManager shareManager] registerClass:aCls forProtocol:protocol];
}

- (void)proto_registerClass:(Class)aCls forProtocol:(Protocol*)protocol
{
    [self.class proto_registerClass:aCls forProtocol:protocol];
}

+ (void)proto_registerForProtocol:(Protocol*)protocol
{
    [self proto_registerClass:self.class forProtocol:protocol];
}

- (void)proto_registerForProtocol:(Protocol*)protocol
{
    [self.class proto_registerForProtocol:protocol];
}

- (void)proto_openProtocol:(Protocol*)protocol config:(void(^)(id module))config show:(void(^)(UIViewController* module))show
{
    [[ModuleManager shareManager] openProtocol:protocol config:config show:show];
}

- (void)proto_showProtocol:(Protocol*)protocol config:(void(^)(id module))config animated:(BOOL)animated
{
    [self proto_openProtocol:protocol config:config show:^(UIViewController *module) {
        
        if ([module isKindOfClass:[UIViewController class]]) {
            UIViewController* moduleController = (UIViewController*)module;
            [moduleController xtt_showAnimated:animated];
        }
        else {
            NSLog(@"module <%@> is not a viewController", module);
        }
    }];
}

- (void)proto_pushProtocol:(Protocol*)protocol config:(void(^)(id module))config animated:(BOOL)animated
{
    [self proto_openProtocol:protocol config:config show:^(UIViewController *module) {
        
        if ([module isKindOfClass:[UIViewController class]]) {
            UIViewController* moduleController = (UIViewController*)module;
            if ([self isKindOfClass:[UIView class]] || [self isKindOfClass:[UIViewController class]]) {
                [(UIView*)self xtt_pushViewController:moduleController animated:animated];
            }
            else {
                [moduleController xtt_showAnimated:animated];
            }
        }
        else {
            NSLog(@"module <%@> is not a viewController", module);
        }
    }];
}

- (void)proto_presentProtocol:(Protocol*)protocol config:(void(^)(id module))config animated:(BOOL)animated
{
    [self proto_openProtocol:protocol config:config show:^(UIViewController *module) {
        
        if ([module isKindOfClass:[UIViewController class]]) {
            UIViewController* moduleController = (UIViewController*)module;
            if ([self isKindOfClass:[UIView class]] || [self isKindOfClass:[UIViewController class]]) {
                [(UIView*)self xtt_presentViewController:moduleController animated:animated];
            }
            else {
                [moduleController xtt_showAnimated:animated];
            }
        }
        else {
            NSLog(@"module <%@> is not a viewController", module);
        }
    }];
}

@end
