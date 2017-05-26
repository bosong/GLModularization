//
//  ViewController.m
//  UnitsDemo
//
//  Created by guanglong on 2017/5/25.
//  Copyright © 2017年 bjhl. All rights reserved.
//

#import "ViewController.h"
#import "HomeModel.h"
#import <YYModel/YYModel.h>

#import <UNRouter/UNRouter.h>

#import "ModuleManager.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray* mDataArray;
@property (nonatomic, strong) UITableView* mTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    // Do any additional setup after loading the view, typically from a nib.
    
    // test YYModel
    HomeModel* hm = [HomeModel new];
    hm.name = @"homepage";
    hm.size = 3;
    NSLog(@"%@", hm.yy_modelDescription);
    
    NSString* url = @"yl://thisishost?&d=f&=&&=a={\"hehe\":\"hh\", \"hei\":\"ei\", \"yingjie\":[\"lgl\", \"lyj\"]}&b=book";
    NSURL* URL = [NSURL URLWithString:url];
    NSLog(@"query:%@", URL.query);
    NSArray* arr = [URL.query componentsSeparatedByString:@"&"];
    NSString* firstStr = [arr firstObject];
    NSLog(@"%@", [firstStr componentsSeparatedByString:@"="]);
    
    // test 路由
    [self router_registerUrl:url handler:^UIViewController* (NSDictionary *params, id extParams) {
        NSLog(@"params:%@", params);
        
        NSString* jsonStr = params[@"a"];
        NSLog(@"jsonStr:%@", jsonStr);
        NSDictionary* jsonDic = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:NULL];
        NSLog(@"jsonDic:%@", jsonDic);
        
        return nil;
    }];
    [self router_openUrl:url extParams:nil show:^(UIViewController *vc) {
        NSLog(@"to open vc:%@", vc);
    }];
    
    // tableView
    self.mDataArray = @[@{@"title":@"聊天", @"url":@"yl://chat?title=聊天"},
                        @{@"title":@"地图", @"url":@"yl://map?title=地图"}].mutableCopy;
    self.mTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:self.mTableView];
    
    // imageView
    UIImageView* imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 222, 100, 100)];
    imgView1.backgroundColor = [UIColor redColor];
    imgView1.image = [UIImage imageNamed:@"banner_register1.png"];
    [self.view addSubview:imgView1];
    
    // test ModuleManager
    UIButton* testMM = [UIButton buttonWithType:UIButtonTypeCustom];
    [testMM setTitle:@"测试MM" forState:UIControlStateNormal];
    [testMM setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [testMM addTarget:self action:@selector(testMMBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    testMM.frame = CGRectMake(100, 180, 100, 40);
    [self.view addSubview:testMM];
}

- (void)testMMBtnPressed:(UIButton*)sender
{
    [[ModuleManager shareManager] openProtocol:@protocol(MapModuleProtocol) config:^(id<MapModuleProtocol> module) {
        [module proto_setModuleParams:@{@"a":@"apple"}];
    } show:^(UIViewController *module) {
        [self xtt_presentViewController:module animated:YES];
    }];
    
//    [self proto_openProtocol:@protocol(MapModuleProtocol) config:nil show:nil];
    
//    [self proto_showProtocol:@protocol(MapModuleProtocol) config:nil animated:YES];
    
//    [self proto_pushProtocol:@protocol(MapModuleProtocol) config:nil animated:NO];
    
//    [self proto_presentProtocol:@protocol(MapModuleProtocol) config:nil animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = self.mDataArray[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id extParams = @"https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Faust_bei_der_Arbeit.JPG/440px-Faust_bei_der_Arbeit.JPG";
    
//    [self router_openUrl:self.mDataArray[indexPath.row][@"url"] extParams:extParams show:^(UIViewController *vc) {
////        [self.navigationController pushViewController:vc animated:YES];
//        [vc xtt_showAnimated:YES];
//    }];
    
    [self router_openUrl:self.mDataArray[indexPath.row][@"url"] extParams:extParams show:nil];
    
//    [self router_pushUrl:self.mDataArray[indexPath.row][@"url"] extParams:extParams animated:YES];
    
//    [self router_showUrl:self.mDataArray[indexPath.row][@"url"] extParams:extParams animated:YES];
    
//    [self router_presentUrl:self.mDataArray[indexPath.row][@"url"] extParams:extParams animated:YES];
}

@end
