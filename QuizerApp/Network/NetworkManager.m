//
//  NetworkManager.m
//  QuizerApp
//
//  Created by Girish Koundinya on 09/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import "NetworkManager.h"
#import <Firebase/Firebase.h>
#import "QuestionParser.h"

@implementation NetworkManager

+ (void)initialize
{
    if (self == [self class]) {
        [self testMethod];
    }
}

//https://wordapp1.firebaseio.com/users
//https://wordapp1.firebaseio.com/scores


+ (void)testMethod {
    
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://wordapp1.firebaseio.com/questions"];
    
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
        
        questions = [QuestionParser parseQuestions:snapshot.value];
    }];
}

+ (NSMutableArray *)questions {
    if (!questions) {
        questions = [NSMutableArray new];
    }
    return questions;
}

@end
