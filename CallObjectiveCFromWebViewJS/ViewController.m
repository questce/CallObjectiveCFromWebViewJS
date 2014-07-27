//
//  ViewController.m
//  CallObjectiveCFromWebViewJS
//
//  Created by user on 2014/07/27.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString* htmlFilePath = [[NSBundle mainBundle] pathForResource:@"res/sample" ofType:@"html"];
    NSString* htmlString = [[NSString alloc] initWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *resURL = [[NSBundle mainBundle] URLForResource:@"res/sample" withExtension:@"html"];
    self.sampleUIWebView.delegate = self;
    [self.sampleUIWebView loadHTMLString:htmlString baseURL:resURL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.scheme isEqualToString:@"js"]) {
        // custom scheme
        [self callNativeMethod: request];
        return NO;
    } else {
        // except custom scheme start load request
        return YES;
    }
}

- (void)callNativeMethod:(NSURLRequest*)request
{
    if([request.URL.host isEqualToString:@"Hello"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Native Method"
                                                        message:@"Native Method called from javascript"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

@end
