//
//  ViewController.m
//  ChatUnit
//
//  Created by guanglong on 2017/5/25.
//  Copyright © 2017年 bjhl. All rights reserved.
//

#import "CUViewController.h"
#import <UNRouter.h>

@interface CUViewController ()

@end

@implementation CUViewController

+ (void)load
{
    [[UNRouter shareRouter] registerUrl:@"yl://chat" handler:^UIViewController *(NSDictionary *queryParams, id extParams) {
        CUViewController* vc = [CUViewController new];
        vc.title = queryParams[@"title"];
        return vc;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
