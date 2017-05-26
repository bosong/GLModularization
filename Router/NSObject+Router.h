//
//  NSObject+Router.h
//  Pods
//
//  Created by guanglong on 2017/5/25.
//
//

#import "UNRouter.h"
#import "ModuleManager.h"

@interface NSObject (Router)

// router
+ (void)router_registerUrl:(NSString*)url handler:(UNRegisterUrlHandler)handler;
- (void)router_registerUrl:(NSString*)url handler:(UNRegisterUrlHandler)handler;

- (void)router_openUrl:(NSString*)url extParams:(id)extParams show:(void(^)(UIViewController* vc))show;

- (void)router_showUrl:(NSString*)url extParams:(id)extParams animated:(BOOL)animated;
- (void)router_pushUrl:(NSString*)url extParams:(id)extParams animated:(BOOL)animated;
- (void)router_presentUrl:(NSString*)url extParams:(id)extParams animated:(BOOL)animated;

// protocol
+ (void)proto_registerClass:(Class)aCls forProtocol:(Protocol*)protocol;
- (void)proto_registerClass:(Class)aCls forProtocol:(Protocol*)protocol;

+ (void)proto_registerForProtocol:(Protocol*)protocol;
- (void)proto_registerForProtocol:(Protocol*)protocol;

- (void)proto_openProtocol:(Protocol*)protocol config:(void(^)(id module))config show:(void(^)(UIViewController* module))show;

- (void)proto_showProtocol:(Protocol*)protocol config:(void(^)(id module))config animated:(BOOL)animated;
- (void)proto_pushProtocol:(Protocol*)protocol config:(void(^)(id module))config animated:(BOOL)animated;
- (void)proto_presentProtocol:(Protocol*)protocol config:(void(^)(id module))config animated:(BOOL)animated;


@end
