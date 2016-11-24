//
//  PushAnimator.m
//  Pop_practice
//
//  Created by use on 16/11/18.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "PushAnimator.h"

@interface PushAnimator ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PushAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL ispush = [fromVC.navigationController.viewControllers indexOfObject:fromVC] < [toVC.navigationController.viewControllers indexOfObject:toVC] ? YES : NO;
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];// 88e0
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];//9a40
    
    UIView *containerView = [transitionContext containerView];
    
    
    CGRect init_rect = CGRectMake(fromView.center.x, fromView.center.y, 1, 1);
    UIBezierPath *init_path = [UIBezierPath bezierPathWithOvalInRect:init_rect];
    UIBezierPath *final_path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(init_rect, -300, -500)];
    
    if (ispush) {
        [containerView addSubview:fromView];
        [containerView addSubview:toView];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = final_path.CGPath;
        toView.layer.mask = maskLayer;
        
        CABasicAnimation *pushAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pushAnimation.fromValue = (__bridge id _Nullable)(init_path.CGPath);
        pushAnimation.toValue = (__bridge id _Nullable)(final_path.CGPath);
        pushAnimation.duration = [self transitionDuration:transitionContext];
        pushAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        pushAnimation.delegate = self;
        
        [maskLayer addAnimation:pushAnimation forKey:@"push_path"];
    } else {
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = init_path.CGPath;
        fromView.layer.mask = maskLayer;
        
        CABasicAnimation *pushAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pushAnimation.fromValue = (__bridge id _Nullable)(final_path.CGPath);
        pushAnimation.toValue = (__bridge id _Nullable)(init_path.CGPath);
        pushAnimation.duration = [self transitionDuration:transitionContext];
        pushAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        pushAnimation.delegate = self;
        
        [maskLayer addAnimation:pushAnimation forKey:@"pop_path"];
    }
}

# pragma mark -- CABasicAnimation的delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    BOOL wasCancled = [self.transitionContext transitionWasCancelled];

    [self.transitionContext completeTransition:!wasCancled];
    
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
