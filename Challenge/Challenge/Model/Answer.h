//
//  Answer.h
//  Challenge
//
//  Created by Vic on 2018-06-05.
//  Copyright © 2018 bluepi0j. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"

@interface Answer : NSObject

@property (strong, nonatomic) NSString *abstractSource;
@property (strong, nonatomic) NSString *abstractURL;
@property (strong, nonatomic) NSString *heading;
@property (strong, nonatomic) NSMutableArray<Topic *> *topics;

@end
