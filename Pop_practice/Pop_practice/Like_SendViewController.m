//
//  Like_SendViewController.m
//  Pop_practice
//
//  Created by use on 16/11/8.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "Like_SendViewController.h"

#import <pop/POP.h>

@interface Like_SendViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *msg_textField;
@property (weak, nonatomic) IBOutlet UIButton *thunderlightButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation Like_SendViewController

#pragma mark -- Button Animation
- (void)showThunderLightButton
{
    if (self.thunderlightButton.isHidden) {
        self.thunderlightButton.hidden = NO;
        self.sendButton.hidden = YES;
        
        POPSpringAnimation *thunderAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
        thunderAnimation.fromValue = @(M_PI/4);
        thunderAnimation.toValue = @(0);
        thunderAnimation.springBounciness = 20.f;
        thunderAnimation.velocity = @(10);
        [self.thunderlightButton.layer pop_addAnimation:thunderAnimation forKey:@"thunderAnimation"];
    }
}

- (void)showSendButton
{
    if (self.sendButton.isHidden) {
        self.sendButton.hidden = NO;
        self.thunderlightButton.hidden = YES;
        
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
        springAnimation.springBounciness = 20.f;
        [self.sendButton pop_addAnimation:springAnimation forKey:@"sendAnimation"];
    }
}

#pragma mark -- UITextFiled Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *temp;
    if (range.length == 0) {
        temp = [NSString stringWithFormat:@"%@%@", textField.text, string];
    } else {
        temp = [textField.text substringToIndex:(textField.text.length - range.length)];
    }
    
    if (temp.length == 0) {
        // show light
        [self showThunderLightButton];
    } else {
        // show send
        [self showSendButton];
    }
    
    return YES;
}

#pragma mark -- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sendButton.hidden = YES;
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
