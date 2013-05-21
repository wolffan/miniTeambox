//
//  RLFTimeViewController.m
//  miniTeambox
//
//  Created by Raimon Lapuente on 21/05/13.
//  Copyright (c) 2013 RaimonLapuente. All rights reserved.
//

#import "RLFTimeViewController.h"
#import "RLFTableViewController.h"

@interface RLFTimeViewController ()

@end

@implementation RLFTimeViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performSearch:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setFrom:nil];
    [self setTo:nil];
    [super viewDidUnload];
}
@end
