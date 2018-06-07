//
//  WebViewController.m
//  Challenge
//
//  Created by Vic on 2018-06-07.
//  Copyright © 2018 bluepi0j. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic) IBOutlet WKWebView *webView;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:self.firstURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView = [[WKWebView alloc]init] ;
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:request];
    self.webView.frame = CGRectMake(self.view.frame.origin.x,44 + [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, self.view.frame.size.height-44 + [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
