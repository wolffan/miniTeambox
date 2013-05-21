//
//  RLFTableViewController.h
//  miniTeambox
//
//  Created by Raimon Lapuente on 20/05/13.
//  Copyright (c) 2013 RaimonLapuente. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLFTimeViewController;

@interface RLFTableViewController : UIViewController <UITableViewDelegate,UITableViewDelegate,UISearchBarDelegate>

- (IBAction)time:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property RLFTimeViewController *time;

@end
