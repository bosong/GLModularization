//
//  UIView+PageSkip.m
//  XXTT
//
//  Created by guanglong on 16/6/13.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import "UIView+PageSkip.h"

@implementation UIView (PageSkip)

- (void)xtt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.xtt_viewController xtt_pushViewController:viewController animated:animated];
}

- (void)xtt_presentViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.xtt_viewController xtt_presentViewController:viewController animated:animated];
}

- (void)xtt_replaceWithViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.xtt_viewController xtt_replaceWithViewController:viewController animated:animated];
}

- (void)xtt_dismissAnimated:(BOOL)animated
{
    [self.xtt_viewController xtt_dismissAnimated:animated];
}

- (UIViewController *)xtt_viewController
{
    UIResponder* nextResponder = self.nextResponder;
    do {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    } while ((nextResponder = nextResponder.nextResponder));
    return nil;
}

@end

@implementation UIViewController(PageSkip)

- (void)xtt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self isKindOfClass:[UINavigationController class]]) {
        [self xtt_my_pushViewController:viewController toNavigationController:(UINavigationController*)self animated:animated];
    }
    else if (self.navigationController) {
        [self xtt_my_pushViewController:viewController toNavigationController:self.navigationController animated:animated];
    }
    else {
        [viewController xtt_showAnimated:animated];
    }
}

- (void)xtt_presentViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController* navi = nil;
    if ([viewController isKindOfClass:[UINavigationController class]]
        || [viewController isKindOfClass:[UITabBarController class]] ) {
        
        navi = viewController;
    }
    else {
        navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    }
    [navi xtt_showAnimated:animated];
}

- (void)xtt_replaceWithViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.navigationController) {
        NSMutableArray* mArr = self.navigationController.viewControllers.mutableCopy;
        NSUInteger index = [mArr indexOfObject:self];
        if (index != NSNotFound) {
            [mArr replaceObjectAtIndex:index withObject:viewController];
            [self.navigationController setViewControllers:mArr animated:animated];
        }
    }
    else {
        [self dismissViewControllerAnimated:YES completion:^{
            [viewController xtt_showAnimated:animated];
        }];
    }
}

- (void)xtt_showAnimated:(BOOL)animated
{
    UIViewController* presentedVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    while (presentedVC.presentedViewController) {
        presentedVC = presentedVC.presentedViewController;
    }
    
    if ([presentedVC isKindOfClass:[UINavigationController class]]) {
        [self xtt_my_pushViewController:self toNavigationController:(UINavigationController*)presentedVC animated:animated];
    }
    else if (presentedVC.navigationController) {
        [self xtt_my_pushViewController:self toNavigationController:presentedVC.navigationController animated:animated];
    }
    else {
        UINavigationController* naviVC = nil;
        if ([self isKindOfClass:[UINavigationController class]]
            || [self isKindOfClass:[UITabBarController class]]) {
            naviVC = (UINavigationController*)self;
        }
        else {
            naviVC = [[UINavigationController alloc] initWithRootViewController:self];
        }
        [presentedVC presentViewController:naviVC animated:animated completion:nil];
    }
}

- (void)xtt_showFromController:(UIViewController*)fromContorller animated:(BOOL)animated
{
    if (fromContorller) {
        [fromContorller xtt_pushViewController:self animated:animated];
    }
    else {
        [self xtt_showAnimated:animated];
    }
}

- (void)xtt_dismissAnimated:(BOOL)animated
{
    if ([self isKindOfClass:[UITabBarController class]]
        || [self isKindOfClass:[UINavigationController class]]) {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
    else {
        if (self.navigationController) {
            if (self.navigationController.viewControllers.count == 1) {
                [self.navigationController dismissViewControllerAnimated:animated completion:nil];
            }
            else {
                NSMutableArray* mVcs = self.navigationController.viewControllers.mutableCopy;
                [mVcs removeObject:self];
                [self.navigationController setViewControllers:mVcs animated:animated];
            }
        }
        else if (self.parentViewController) {
            if (self.parentViewController.childViewControllers.count == 1) {
                [self.parentViewController dismissViewControllerAnimated:animated completion:nil];
            }
            else {
                [self removeFromParentViewController];
                [self.view removeFromSuperview];
            }
        }
        else {
            [self dismissViewControllerAnimated:animated completion:nil];
        }
    }
}

#pragma mark - - private
- (void)xtt_my_pushViewController:(UIViewController*)viewController
           toNavigationController:(UINavigationController*)navigationController
                         animated:(BOOL)animated
{
    assert([navigationController isKindOfClass:[UINavigationController class]]);
    if ([viewController isKindOfClass:[UINavigationController class]]
        || [viewController isKindOfClass:[UITabBarController class]] ) {
        [navigationController presentViewController:viewController animated:animated completion:nil];
    }
    else {
        [navigationController pushViewController:viewController animated:animated];
    }
}

@end
