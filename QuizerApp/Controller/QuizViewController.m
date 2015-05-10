//
//  QuizViewController.m
//  QuizerApp
//
//  Created by Bala on 10/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import "QuizViewController.h"
#import "OptionsCell.h"
#import "NetworkManager.h"
#import "Question.h"

@interface QuizViewController () <UITableViewDataSource, UITabBarDelegate>
{
    NSArray *options;
    NSInteger currentQuestionIndex;
    Question *currentQuestion;
    NSArray *colors;
}
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UITableView *optionsListTableView;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    currentQuestionIndex = 0;
    if ([NetworkManager questions].count) {
        
        currentQuestion = [NetworkManager questions][currentQuestionIndex];
        [self changeContentToCurrentQuestion];
    }
}

- (void)changeQuestionAndReloadView {

    [self changeToNextQuestion];
    [self changeContentToCurrentQuestion];
}

- (void)changeContentToCurrentQuestion {
    
    _questionLabel.text = currentQuestion.qWord;
    [_optionsListTableView reloadData];
}

- (void)changeToNextQuestion {
    
    currentQuestionIndex += 1;
    currentQuestion = [NetworkManager questions][currentQuestionIndex];
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return currentQuestion.choices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell"];
    
    cell.choiceLabel.text = [NSString stringWithFormat:@"%@", currentQuestion.choices[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([currentQuestion.choices[indexPath.row] isEqualToString:currentQuestion.answer]) {
        [[[UIAlertView alloc] initWithTitle:@"Alert!!!" message:@"Correct" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Alert!!!" message:@"Oops! Wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    [self changeQuestionAndReloadView];
}


@end
