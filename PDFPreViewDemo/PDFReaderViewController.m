//
//  PDFReaderViewController.m
//  PDFPreViewDemo
//
//  Created by 何发松 on 2017/6/28.
//  Copyright © 2017年 HeRay. All rights reserved.
//

#import "PDFReaderViewController.h"
#import <WebKit/WebKit.h>

@interface PDFReaderViewController ()<WKNavigationDelegate>

@end

@implementation PDFReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    WKWebViewConfiguration *configuration = [WKWebViewConfiguration];
    WKWebView *pdfReaderView = [[WKWebView alloc] initWithFrame:self.view.frame];
    pdfReaderView.navigationDelegate = self;
    [pdfReaderView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.tutorialspoint.com/ios/ios_tutorial.pdf"]]];
    [self.view addSubview:pdfReaderView];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"123");
//    [self presentLoadinghud];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"456");
//    [self dismissAllTips];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
