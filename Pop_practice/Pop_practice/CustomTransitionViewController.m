//
//  CustomTransitionViewController.m
//  Pop_practice
//
//  Created by use on 16/11/8.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "CustomTransitionViewController.h"
#import "CustomModelViewController.h"
#import "ToViewController.h"

#import "PresentingAnimationController.h"
#import "DismissingAnimationController.h"
#import "PushAnimator.h"
#import <pop/POP.h>

@interface CustomTransitionViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) PushAnimator *pushAnimator;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation CustomTransitionViewController

#pragma mark -- Present

- (IBAction)didClickedPresent:(UIButton *)sender {
    CustomModelViewController *modelVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomModelViewController"];
    modelVC.transitioningDelegate = self;
    modelVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:modelVC animated:YES completion:^{
        
    }];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[PresentingAnimationController alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissingAnimationController alloc] init];
}

#pragma mark -- Push

- (IBAction)didClickedPush:(UIButton *)sender {
    ToViewController *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ToViewController"];
    [self.navigationController pushViewController:toVC animated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [PushAnimator new];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return  self.interactiveTransition;
}


- (void)panFunc:(UIPanGestureRecognizer *)pan
{
    CGFloat distance = [pan translationInView:self.view].x;
    if (distance >= 0) {
        CGFloat percent = distance / self.view.bounds.size.width;
        percent = MAX(0.0, MIN(percent, 1.0));
        
        if (pan.state == UIGestureRecognizerStateBegan) {
            self.interactiveTransition = [UIPercentDrivenInteractiveTransition new];
            ToViewController *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ToViewController"];
            [self.navigationController pushViewController:toVC animated:YES];
        } else if (pan.state == UIGestureRecognizerStateChanged) {
            [self.interactiveTransition updateInteractiveTransition:percent];
        } else {
            if (percent >= 0.5) {
                [self.interactiveTransition finishInteractiveTransition];
            } else {
                [self.interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
        }
    }
}

#pragma mark -- LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFunc:)];
    [self.view addGestureRecognizer:pan];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
