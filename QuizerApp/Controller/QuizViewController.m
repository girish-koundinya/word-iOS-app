//
//  QuizViewController.m
//  QuizerApp
//
//  Created by Bala on 10/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController () <UITableViewDataSource, UITabBarDelegate>
{
    NSArray *choices;
    
}
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UITableView *answersListTableView;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    choices = @[@"option1", @"option2", @"option3", @"option4"];
}

#pragma mark - UITableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

@end
