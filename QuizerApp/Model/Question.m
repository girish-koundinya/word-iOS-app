//
//  Question.m
//  QuizerApp
//
//  Created by Girish Koundinya on 09/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import "Question.h"

@implementation Question

- (id)initWithDictionary:(NSDictionary *)dict {

    self = [super init];
    if (self) {
        if (dict[@"qWord"] && dict[@"choices"] && dict[@"answer"]) {

            self.qWord = dict[@"qWord"] ?: @"";
            self.choices = dict[@"choices"] ?: @[];
            self.answer = dict[@"answer"] ?: @"";
        } else {
            NSLog(@"question json issue");
        }
    }
    return self;
}

@end
