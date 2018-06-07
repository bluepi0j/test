//
//  ViewController.m
//  Challenge
//
//  Created by Vic on 2018-06-05.
//  Copyright © 2018 bluepi0j. All rights reserved.
//

#import "ViewController.h"
#import "AnswerManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[AnswerManager sharedManager] requestApiWithURL:@"http://api.duckduckgo.com/?q=apple&format=json&pretty=1" success:^{
        NSLog(@"%@", [[AnswerManager sharedManager] allTopics]);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
//    NSLog(@"%@", topicsArray);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
