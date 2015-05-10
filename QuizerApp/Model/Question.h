//
//  Question.h
//  QuizerApp
//
//  Created by Girish Koundinya on 09/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, strong) NSString* qWord;
@property (nonatomic, strong) NSArray * choices;
@property (nonatomic, strong) NSString* answer;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
