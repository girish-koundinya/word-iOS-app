//
//  NetworkManager.m
//  QuizerApp
//
//  Created by Girish Koundinya on 09/05/15.
//  Copyright (c) 2015 Bala. All rights reserved.
//

#import "NetworkManager.h"
#import <Firebase/Firebase.h>

@implementation NetworkManager


+(void)testMethod {
    
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://wordapp1.firebaseio.com/questions"];
    
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];

    
    
}

@end
