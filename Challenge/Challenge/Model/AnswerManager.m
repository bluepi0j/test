//
//  AnswerManager.m
//  Challenge
//
//  Created by Vic on 2018-06-05.
//  Copyright © 2018 bluepi0j. All rights reserved.
//

#import "AnswerManager.h"
#import "AFNetworking.h"
#import "Answer.h"

@interface AnswerManager()
@property (nonatomic, strong) Answer *answer;
@property (nonatomic, strong) NSMutableDictionary *topicsNameDic;
@end


@implementation AnswerManager

+ (instancetype)sharedManager {
    static AnswerManager* answerManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        answerManager = [[self alloc] init];
    });
    return answerManager;
}

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//    }
//    return self;
//}


- (void)requestApiWithURL:(NSString *)url success:(void (^)(void))success failure:(void (^)(NSError *))failure {
    NSURL *restApi = [NSURL URLWithString:url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"application/x-javascript", nil];

    [manager GET:restApi.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *jsonDict = (NSDictionary *) responseObject;
        self.answer.abstractURL = jsonDict[@"AbstractURL"];
        self.answer.abstractSource = jsonDict[@"AbstractSource"];
        self.answer.heading = jsonDict[@"Heading"];
        [self initTopicsWith:jsonDict];
        if (success) {
            success();
        }
//        NSLog(@"%@", jsonDict);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if(failure) {
            failure(error);
        }
        NSLog(@"Error: %@", error);
    }];
}

- (NSMutableDictionary *)topicsNameDic {
    if(!_topicsNameDic) {
        _topicsNameDic = [[NSMutableDictionary alloc]init];
    }
    return _topicsNameDic;
}

- (Answer *)answer {
    if(!_answer) {
        _answer = [[Answer alloc]init];
    }
    return _answer;
}

- (void)initTopicsWith: (NSDictionary *)JSONDic {
    NSArray *topicList = JSONDic[@"RelatedTopics"];
    for (NSDictionary *topicDic in topicList) {
        if ([topicDic objectForKey:@"Topics"]) {
            for (NSDictionary *namedTopicDic in [topicDic objectForKey:@"Topics"]) {
                
                Topic *topic = [self buildTopic:namedTopicDic];
                if (![self.topicsNameDic objectForKey:[topicDic objectForKey:@"Name"]]) {
                    self.topicsNameDic[[topicDic objectForKey:@"Name"]] = [[NSMutableArray alloc] init];
                }
                 [self.topicsNameDic[[topicDic objectForKey:@"Name"]] insertObject:topic atIndex:0];
                [self.answer.topics addObject:topic];
            }
            
        } else {
            
            Topic *topic = [self buildTopic:topicDic];
            
            if(![self.topicsNameDic objectForKey:@"NONAME"]) {
                self.topicsNameDic[@"NONAME"] = [[NSMutableArray alloc] init];
            }
            [self.topicsNameDic[@"NONAME"] insertObject:topic atIndex:0];
            
            [self.answer.topics addObject:topic];
        }
    }
    
}

- (Topic *)buildTopic:(NSDictionary *)dic {
    Topic *topic = [[Topic alloc] init];
    topic.firstURL = [dic objectForKey:@"FirstURL"];
    topic.iconURL = [[dic objectForKey:@"Icon"] objectForKey:@"URL"];
    topic.text = [dic objectForKey:@"Text"];
    topic.result = [dic objectForKey:@"Result"];
    if([dic objectForKey:@"Name"]) {
        topic.name = [dic objectForKey:@"Name"];
    } else {
        topic.name = @"NONAME";
    }
    return topic;
}

- (NSArray *)allTopics {
    return self.answer.topics;
}

- (NSDictionary *)typeNameTopicDic {
    return self.topicsNameDic;
}

@end
