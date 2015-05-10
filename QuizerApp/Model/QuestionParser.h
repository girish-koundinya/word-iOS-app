//
//  QuestionParser.h
//  QuizerApp
//
//  Created by Bala on 10/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Question.h"

@interface QuestionParser : NSObject

+ (NSMutableArray *)parseQuestions:(NSDictionary *)questionsDict;


@end
