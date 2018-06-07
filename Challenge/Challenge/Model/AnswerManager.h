//
//  AnswerManager.h
//  Challenge
//
//  Created by Vic on 2018-06-05.
//  Copyright © 2018 bluepi0j. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerManager : NSObject
+ (instancetype)sharedManager;
- (NSArray *)allTopics;
- (void)requestApiWithURL:(NSString *)url success:(void (^)(void))success failure:(void (^)(NSError *))failure;
@end
