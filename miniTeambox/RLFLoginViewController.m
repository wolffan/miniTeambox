//
//  RLFLoginViewController.m
//  miniTeambox
//
//  Created by Raimon Lapuente on 20/05/13.
//  Copyright (c) 2013 RaimonLapuente. All rights reserved.
//

#import "RLFLoginViewController.h"
#import "RLFTableViewController.h"

@interface RLFLoginViewController ()

@end

@implementation RLFLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// We load the teambox view in order to login (if we haven't yet).
    NSURL *url = [[NSURL alloc] initWithString:@"https://teambox.com/login"];
    self.login.delegate = self;
    [self.login loadRequest:[[NSURLRequest alloc] initWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - webView delegates

// we'll check for the url's until we hit the url of the authenticated status
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"request: %@",request);
    if ([[[request URL] absoluteString] isEqualToString:@"https://teambox.com/#!/"]) {
        //create the view
        RLFTableViewController *table = [[RLFTableViewController alloc] init];
        [self.navigationController pushViewController:table animated:NO];
        
        
    }
    return YES;
}

@end
