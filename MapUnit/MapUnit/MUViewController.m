//
//  ViewController.m
//  MapUnit
//
//  Created by guanglong on 2017/5/25.
//  Copyright © 2017年 bjhl. All rights reserved.
//

#import "MUViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UNRouter.h>
#import <ModuleManager.h>

@interface MUViewController ()<MapModuleProtocol>

@property (nonatomic, copy) NSString* imgUrl;

@end

@implementation MUViewController

+ (void)load
{
    [self router_registerUrl:@"yl://map" handler:^UIViewController *(NSDictionary *queryParams, id extParams) {
        MUViewController* vc = [MUViewController new];
        vc.imgUrl = (NSString*)extParams;
        vc.title = queryParams[@"title"];
        return vc;
    }];
    
    // 或者采用 protocol 的方式
    [[ModuleManager shareManager] registerClass:self.class forProtocol:@protocol(MapModuleProtocol)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imgView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:imgView];
    
//    http://img3.imgtn.bdimg.com/it/u=4271053251,2424464488&fm=23&gp=0.jpg
    
    NSURL* imgURL = [NSURL URLWithString:self.imgUrl?:@"http://b.hiphotos.baidu.com/baike/w%3D268%3Bg%3D0/sign=92e00c9b8f5494ee8722081f15ce87c3/29381f30e924b899c83ff41c6d061d950a7bf697.jpg"];
    [imgView sd_setImageWithURL:imgURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"error:%@", error);
    }];
    
    UIImageView* imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 222, 100, 100)];
    imgView1.backgroundColor = [UIColor redColor];
    imgView1.image = [UIImage imageNamed:@"banner_register.png"];
    [self.view addSubview:imgView1];
    
    // test 内存泄漏
//    __weak typeof(self) weakSelf = self;
//    [self router_registerUrl:@"yl://map" handler:^UIViewController *(NSDictionary *queryParams, id extParams) {
//        NSLog(@"self:%@", weakSelf);
//        return nil;
//    }];
}

#pragma mark - - MapModuleProtocol
- (void)proto_setModuleParams:(NSDictionary *)params
{
    NSLog(@"pass params:%@", params);
    self.title = [NSString stringWithFormat:@"%@-%i", params[@"a"], arc4random()%100];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self xtt_dismissAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}


@end
