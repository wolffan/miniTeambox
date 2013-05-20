//
//  RLFTableViewController.m
//  miniTeambox
//
//  Created by Raimon Lapuente on 20/05/13.
//  Copyright (c) 2013 RaimonLapuente. All rights reserved.
//

#import "RLFTableViewController.h"
#import "RLFAPI.h"

@interface RLFTableViewController ()

@end

@implementation RLFTableViewController
{
    NSArray *task_list;
    NSMutableArray *filtered_list;
    BOOL isFiltered;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.search.showsCancelButton = YES;
        self.search.placeholder = @"Type to search";
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

- (void) viewWillAppear:(BOOL)animated
{
    //we create a new view with the objects
    RLFAPI *api = [[RLFAPI alloc] init];
    NSDictionary *dict = [api getTasks];
    task_list = [dict objectForKey:@"objects"];
    [self.mainTable reloadData];
}

#pragma mark - Table Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFiltered) {
        return [filtered_list count];
    } else {
        return [task_list count];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier = @"listCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary *task;
    if (isFiltered) {
        task = [filtered_list objectAtIndex:indexPath.row];
    } else {
        task = [task_list objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = [task objectForKey:@"name"];
    cell.detailTextLabel.text = [task objectForKey:@"updated_at"];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - searchBar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        //no text
        isFiltered = NO;
    } else {
        isFiltered = YES;
        filtered_list = [[NSMutableArray alloc] init];
        
        for (NSDictionary *elem in task_list) {
            NSRange nameRange = [[elem objectForKey:@"name"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (nameRange.location != NSNotFound) {
                [filtered_list addObject:elem];
            }
        }
    }
    [self.mainTable reloadData];
}

@end
