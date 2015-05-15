//
//  ScoreViewController.m
//  QuizerApp
//
//  Created by Bala on 14/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


#pragma mark - UITableView Delegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideScoreView:(id)sender {
    
    [self.frostedViewController hideMenuViewController];
}

@end
