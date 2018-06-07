//
//  Answer.m
//  Challenge
//
//  Created by Vic on 2018-06-05.
//  Copyright © 2018 bluepi0j. All rights reserved.
//

#import "Answer.h"

@implementation Answer

- (NSMutableArray *)topics {
    if(!_topics) {
        _topics = [[NSMutableArray alloc]init];
    }
    return _topics;
}
@end
