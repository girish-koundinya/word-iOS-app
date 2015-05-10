//
//  QuestionParser.m
//  QuizerApp
//
//  Created by Bala on 10/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import "QuestionParser.h"

@implementation QuestionParser

+ (NSMutableArray *)parseQuestions:(NSDictionary *)questionsDict {

    NSMutableArray *questions = [NSMutableArray new];
    for (NSString *key in questionsDict) {
        
        [questions addObject:[[Question alloc] initWithDictionary:questionsDict[key]]];
    }
    
    return questions;
}

@end
