//
//  ViewController.m
//  Pop_practice
//
//  Created by use on 16/11/7.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "ViewController.h"
#import "AnimatableCell.h"
#import "Like_SendViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

NSString * const cellId = @"cellId";

# pragma mark -- UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self performSegueWithIdentifier:@"toLikeSend" sender:self];
            break;
        }
        case 1:
        {
            [self performSegueWithIdentifier:@"toWrong" sender:self];
            break;
        }
        case 2:
        {
            [self performSegueWithIdentifier:@"toTransition" sender:self];
            break;
        }
        default:
            break;
    }
}

# pragma mark -- UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titles = @[@"Facebook Lick & Send", @"Wrong Password", @"Custom VC Transition"];
    AnimatableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[AnimatableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];;
    }
    cell.backgroundColor = [UIColor yellowColor];
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.textColor = [UIColor purpleColor];
    return cell;
}

# pragma mark -- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[AnimatableCell class] forCellReuseIdentifier:cellId];
    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
