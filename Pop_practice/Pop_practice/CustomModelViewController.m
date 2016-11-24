//
//  CustomModelViewController.m
//  Pop_practice
//
//  Created by use on 16/11/8.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "CustomModelViewController.h"

@interface CustomModelViewController ()

@end

@implementation CustomModelViewController

#pragma mark -- close

- (IBAction)didClickedClose:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.cornerRadius = 10.f;
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
