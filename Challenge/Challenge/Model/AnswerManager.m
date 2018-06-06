//
//  AnswerManager.m
//  Challenge
//
//  Created by Vic on 2018-06-05.
//  Copyright © 2018 bluepi0j. All rights reserved.
//

#import "AnswerManager.h"

@implementation AnswerManager


+ (instancetype)sharedManager {
    static AnswerManager* answerManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        answerManager = [[self alloc] init];
    });
    return answerManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}
@end
