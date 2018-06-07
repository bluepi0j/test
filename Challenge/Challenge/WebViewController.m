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
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:self.firstURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView = [[WKWebView alloc]init] ;
    self.webView.UIDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.navigationDelegate = self;
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];

    [self.webView loadRequest:request];
    self.webView.frame = CGRectMake(self.view.frame.origin.x,44 + [[UIApplication sharedApplication] statusBarFrame].size.height + 2, self.view.frame.size.width, self.view.frame.size.height-44 - [[UIApplication sharedApplication] statusBarFrame].size.height - 2);
    
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else{
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }

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
