//
//  RootViewController.m
//  QuizerApp
//
//  Created by Bala on 14/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib {
    
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"quizController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"scoreController"];
}

@end
