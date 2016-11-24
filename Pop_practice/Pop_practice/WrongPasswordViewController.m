//
//  WrongPasswordViewController.m
//  Pop_practice
//
//  Created by use on 16/11/8.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "WrongPasswordViewController.h"

#import "POP.h"

@interface WrongPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation WrongPasswordViewController

#pragma mark -- login

- (IBAction)login:(UIButton *)sender {
    POPSpringAnimation *loginAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    loginAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
    loginAnimation.springBounciness = 20.f;
    [sender pop_addAnimation:loginAnimation forKey:@"login"];
    
    _passwordTextField.textColor = [UIColor redColor];
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    springAnimation.velocity = @(3000);
    springAnimation.springBounciness = 20.f;
    [_passwordTextField.layer pop_addAnimation:springAnimation forKey:@"textfield"];
}

#pragma mark -- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
