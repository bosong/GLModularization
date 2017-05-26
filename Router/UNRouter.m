//
//  UNRouter.m
//  UnitsDemo
//
//  Created by guanglong on 2017/5/25.
//  Copyright © 2017年 bjhl. All rights reserved.
//

#import "UNRouter.h"

@interface UNRouter ()

@property (nonatomic, strong) NSMutableDictionary* urlHandlerMap;

@end

@implementation UNRouter

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)shareRouter
{
    static UNRouter* sshareRouter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sshareRouter = [[self alloc] init];
    });
    return sshareRouter;
}

// 这个方法很可能会在 +load 方法中调用多次，为了防止拖慢启动速度，考虑采用异步的方式
- (void)registerUrl:(NSString *)url handler:(UNRegisterUrlHandler)handler
{
    assert(url.length && handler);
    NSString* key = [self keyFromUrl:url queryParams:NULL];
    [self.urlHandlerMap setValue:handler forKey:key];
}

- (void)openUrl:(NSString *)url extParams:(id)extParams show:(void (^)(UIViewController *))show
{
    UIViewController* vc = [self controllerFromUrl:url extParams:extParams];
    if (vc) {
        if (show) {
            show(vc);
        }
        else {
            // 默认 show 方式
            [vc xtt_showAnimated:YES];
        }
    }
}

- (UIViewController *)controllerFromUrl:(NSString *)url extParams:(id)extParams
{
    assert(url.length);
    NSDictionary* queryParams = nil;
    NSString* key = [self keyFromUrl:url queryParams:&queryParams];
    UNRegisterUrlHandler handler = self.urlHandlerMap[key];
    if (handler) {
        return handler(queryParams, extParams);
    }
    else {
        NSLog(@"尚未注册 routerUrl: <%@>", url);
        return nil;
    }
}

- (NSString*)keyFromUrl:(NSString*)url queryParams:(NSDictionary**)queryParams
{
    NSString* urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL* URL = [NSURL URLWithString:urlString];
    assert(URL.scheme.length && URL.host.length);
    
    NSString* key = [NSString stringWithFormat:@"%@://%@", URL.scheme, URL.host];
    
    if (queryParams != NULL) {
        NSString* queryStr = URL.query;
        if (queryStr.length) {
            
            NSMutableDictionary* mDic = @{}.mutableCopy;
            NSScanner* scanner = [NSScanner scannerWithString:queryStr];
            NSCharacterSet* excludeSet = [NSCharacterSet characterSetWithCharactersInString:@"&="];
            
            while (!scanner.isAtEnd) {
                NSString* abc = nil;
                [scanner scanUpToString:@"=" intoString:&abc];
                [scanner scanString:@"=" intoString:NULL];
                abc = [abc stringByTrimmingCharactersInSet:excludeSet];
                if (!abc.length) {
                    continue;
                }
                
                NSString* cde = nil;
                [scanner scanUpToString:@"&" intoString:&cde];
                [scanner scanString:@"&" intoString:NULL];
                cde = [cde stringByTrimmingCharactersInSet:excludeSet];
                cde = [cde stringByRemovingPercentEncoding];
                
                [mDic setValue:cde forKey:abc];
            }
            *queryParams = mDic;
        }
    }
    return key;
}

- (NSMutableDictionary *)urlHandlerMap
{
    if (!_urlHandlerMap) {
        _urlHandlerMap = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _urlHandlerMap;
}

@end
