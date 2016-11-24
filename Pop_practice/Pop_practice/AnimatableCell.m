//
//  AnimatableCell.m
//  Pop_practice
//
//  Created by use on 16/11/7.
//  Copyright © 2016年 wjp. All rights reserved.
//

#import "AnimatableCell.h"

#import "POP.h"

@implementation AnimatableCell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.1;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.5, 1.5)];
        [self.textLabel pop_addAnimation:scaleAnimation forKey:@"scalingUp"];
    } else {
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        springAnimation.springBounciness = 20.f;
        [self.textLabel pop_addAnimation:springAnimation forKey:@"springAnimation"];
    }
}

@end
