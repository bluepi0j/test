//
//  ViewController.m
//  Challenge
//
//  Created by Vic on 2018-06-05.
//  Copyright © 2018 bluepi0j. All rights reserved.
//

#import "ViewController.h"
#import "ItemTableViewCell.h"
#import "AnswerManager.h"
#import "Topic.h"
#import "UIImageView+AFNetworking.h"
#import "WebViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Topic *> *topics;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    shadowView.backgroundColor = [UIColor grayColor];
//    shadowView.center = self.view.center;
    [self.view addSubview:shadowView];
    
    activityView.center = self.view.center;
    [activityView startAnimating];
    [shadowView addSubview:activityView];
    
    // Do any additional setup after loading the view, typically from a nib.
    [[AnswerManager sharedManager] requestApiWithURL:@"http://api.duckduckgo.com/?q=apple&format=json&pretty=1" success:^{
//        NSLog(@"%@", [[AnswerManager sharedManager] allTopics]);
        self.topics = [[AnswerManager sharedManager] allTopics];
        [shadowView removeFromSuperview];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
//    NSLog(@"%@", topicsArray);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// MARK: - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.text.text = self.topics[indexPath.row].text;
    NSURL *url = [NSURL URLWithString:self.topics[indexPath.row].iconURL];
    [cell.icon setImageWithURL:url];
    if ([self.topics[indexPath.row].iconURL isEqualToString:@""]) {
        cell.icon.image = [UIImage imageNamed:@"no image"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    vc.firstURL = self.topics[indexPath.row].firstURL;
    [self presentViewController:vc animated:YES completion:nil];
}

#define ICONWIDTH 60
#define MARGIN 24
#define SPACE 20

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [self calculateHeightWith:self.topics[indexPath.row].text];
    if (height < ICONWIDTH) {
        return ICONWIDTH + 10;
    }
    return height + 10;
}


- (CGFloat)calculateHeightWith: (NSString *) string {
    if (!string) {
        return 0;
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}];
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - MARGIN * 2 - ICONWIDTH - SPACE - 70, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];

    return ceilf(rect.size.height);
}
@end
