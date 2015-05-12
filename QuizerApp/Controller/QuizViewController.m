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
    NSMutableArray *randomColors;
    BOOL isNextQuestion;
}
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UITableView *optionsListTableView;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    currentQuestionIndex = -1;
    
    colors = @[[UIColor greenColor], [UIColor redColor], [UIColor orangeColor], [UIColor yellowColor]];
    randomColors = [NSMutableArray new];
    
    [self changeQuestionAndReloadView];
}

//TODO: Move the Presentation logics to Cell/ViewModel...

- (NSInteger)getRandomNonRepeatingNumberWithinFour {

    if (randomColors.count) {
        NSInteger randomIndex = arc4random() % [randomColors count];
        return randomIndex;
    }
    return 0;
}

- (UIColor *)getColorForRandomIndex:(NSInteger)randomIndex {
 
    if (randomIndex < randomColors.count) {
        UIColor *randomColor = randomColors[randomIndex];
        [randomColors removeObjectAtIndex:randomIndex];
        return randomColor;
    }
    return nil;
}

- (void)changeQuestionAndReloadView {

    [self changeToNextQuestion];
}

- (void)changeContentToCurrentQuestion {
    
    _questionLabel.text = currentQuestion.qWord;
    [_optionsListTableView reloadData];
}

- (void)changeToNextQuestion {
    
    currentQuestionIndex += 1;
    if (currentQuestionIndex < [NetworkManager questions].count) {
        
        currentQuestion = [NetworkManager questions][currentQuestionIndex];

        // Reloading RandomColors Array from first
        [randomColors addObjectsFromArray:colors];
        
        // And Reload the content
        [self changeContentToCurrentQuestion];

    } else {
        // Alert the user that question is over
        [[[UIAlertView alloc] initWithTitle:@"Alert!!!" message:@"Thalaiva, you are great! /n GAME OVER" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return currentQuestion.choices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell"];

    cell.choiceLabel.text = [NSString stringWithFormat:@"%@", currentQuestion.choices[indexPath.row]];
    UIColor *backgroundColor = [self getColorForRandomIndex:[self getRandomNonRepeatingNumberWithinFour]];
    if (backgroundColor) {
        cell.backgroundColor = backgroundColor;
    } else {
        cell.backgroundColor = [UIColor blackColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return tableView.frame.size.height / 4;
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
