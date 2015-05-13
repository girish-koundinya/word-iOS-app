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

@interface UIColor (AppColor)

+ (UIColor *)appOrangeColor;
+ (UIColor *)appBlueColor;
+ (UIColor *)appGreenColor;
+ (UIColor *)appRedColor;

@end

@implementation UIColor (AppColor)

+ (UIColor *)appOrangeColor {
    
    return [UIColor colorWithRed:231.0/255.0 green:149.0/255.0 blue:77.0/255.0 alpha:1.0];
}

+ (UIColor *)appBlueColor {
    
    return [UIColor colorWithRed:60.0/255.0 green:122.0/255.0 blue:218.0/255.0 alpha:1.0];
}

+ (UIColor *)appGreenColor {
    
    return [UIColor colorWithRed:45.0/255.0 green:180.0/255.0 blue:115.0/255.0 alpha:1.0];
}

+ (UIColor *)appRedColor {
    
    return [UIColor colorWithRed:179.0/255.0 green:57.0/255.0 blue:61.0/255.0 alpha:1.0];
}

@end

@interface QuizViewController () <UITableViewDataSource, UITabBarDelegate>
{
    NSArray *options;
    NSInteger currentQuestionIndex;
    Question *currentQuestion;
    NSArray *colors;
    NSMutableArray *randomColors;
}

@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UITableView *optionsListTableView;
@property (nonatomic, retain) IBOutlet UIImageView *resultImageView;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentQuestionIndex = -1;
    
    colors = @[[UIColor appGreenColor], [UIColor appRedColor], [UIColor appOrangeColor], [UIColor appBlueColor]];
    randomColors = [NSMutableArray new];
    _optionsListTableView.bounces = NO;
    [self changeQuestionAndReloadView];
}

//TODO: Move the Presentation logics to Cell/ViewModel...

- (NSInteger)getRandomNonRepeatingNumberWithinFour {
    
    if (randomColors.count) {
        NSInteger randomIndex = arc4random() % [randomColors count];
        return randomIndex;
    }
    return -1;
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
        
        _resultImageView.image = [UIImage imageNamed:@"correct.png"];
    } else {
        
        _resultImageView.image = [UIImage imageNamed:@"wrong.png"];
    }
    _resultImageView.backgroundColor = [self.optionsListTableView cellForRowAtIndexPath:indexPath].backgroundColor;
    
    [self showResultWithAnimation];
}

- (void)showResultWithAnimation {
    
    [UIView animateWithDuration:0.40 animations:^{
        
        _resultImageView.alpha = 1.0;
        _optionsListTableView.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.4 animations:^{
            
            _resultImageView.alpha = 0.0;
        } completion:^(BOOL finished) {
            
            _optionsListTableView.userInteractionEnabled = YES;
            [self changeQuestionAndReloadView];
        }] ;
    }];
}

@end
