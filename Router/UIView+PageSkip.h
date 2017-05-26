//
//  UIView+PageSkip.h
//  XXTT
//
//  Created by guanglong on 16/6/13.
//  Copyright © 2016年 bjhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerPageSkipProtocol <NSObject>

@required
- (void)xtt_pushViewController:(UIViewController*)viewController animated:(BOOL)animated;

- (void)xtt_presentViewController:(UIViewController*)viewController animated:(BOOL)animated;

- (void)xtt_replaceWithViewController:(UIViewController*)viewController animated:(BOOL)animated;

- (void)xtt_dismissAnimated:(BOOL)animated;

@end

@interface UIView (PageSkip) <UIViewControllerPageSkipProtocol>

@property (nonatomic, readonly) UIViewController* xtt_viewController;

@end

@interface UIViewController (PageSkip) <UIViewControllerPageSkipProtocol>

- (void)xtt_showFromController:(UIViewController*)fromContorller animated:(BOOL)animated;

- (void)xtt_showAnimated:(BOOL)animated;


@end
