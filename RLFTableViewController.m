//
//  RLFTableViewController.m
//  miniTeambox
//
//  Created by Raimon Lapuente on 20/05/13.
//  Copyright (c) 2013 RaimonLapuente. All rights reserved.
//

#import "RLFTableViewController.h"
#import "RLFAPI.h"
#import "RLFTimeViewController.h"
#import "RLFCell.h"

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
    
    //Load Custom Cell
    UINib *nib = [UINib nibWithNibName:@"RLFCell" bundle:nil];
    //register the nib with a cell identifier
    [[self mainTable] registerNib:nib forCellReuseIdentifier:@"RLFCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    //we create a new view with the objects or we filter results by Date (if we come back from time view)
    if (isFiltered) {
        [self filterByDate];
        [self.search resignFirstResponder];
    } else {
        RLFAPI *api = [[RLFAPI alloc] init];
        NSDictionary *dict = [api getTasks];
        task_list = [dict objectForKey:@"objects"];
        [self.mainTable reloadData];
    }
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl setTintColor:[UIColor grayColor]];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"Reloading ..."];
    [self.mainTable addSubview:refreshControl];
    
    [self.mainTable setBackgroundColor:[UIColor clearColor]];
}

- (void) refresh: (UIRefreshControl *) sender
{
    [sender beginRefreshing];
    RLFAPI *api = [[RLFAPI alloc] init];
    NSDictionary *dict = [api getTasks];
    task_list = [dict objectForKey:@"objects"];
    //[self.mainTable reloadData];
    [sender endRefreshing];
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
    RLFCell *cell;
    static NSString *identifier = @"listCell";
    
    cell = (RLFCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RLFCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *task;
    if (isFiltered) {
        task = [filtered_list objectAtIndex:indexPath.row];
    } else {
        task = [task_list objectAtIndex:indexPath.row];
    }
    cell.name.text = [task objectForKey:@"name"];
    cell.date.text = [task objectForKey:@"updated_at"];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.chats.text = [NSString stringWithFormat:@"%@",[task objectForKey:@"comments_count"]];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - searchBar

//Filter task table by name
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

- (void)viewDidUnload {
    [super viewDidUnload];
}

//Present Modal view for time choosing
- (IBAction)time:(id)sender {
    self.time = [[RLFTimeViewController alloc] init];
    isFiltered = YES;
    [[self navigationController] presentModalViewController:self.time animated:YES];
}

/* Filter the results from the table by start date and end date provided by the time modal view
 */
- (void) filterByDate
{
    isFiltered = YES;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    filtered_list = [[NSMutableArray alloc] init];
    for (NSDictionary *elem in task_list) {
        NSArray *split = [[elem objectForKey:@"updated_at"]  componentsSeparatedByString:@" "];
        NSDate *current = [format dateFromString:[split objectAtIndex:0]];
        if ([current compare:self.time.from.date] == NSOrderedDescending && [current compare:self.time.to.date] == NSOrderedAscending) {
            [filtered_list addObject:elem];
        }
    }
    [self.mainTable reloadData];
}

- (IBAction)resetData:(id)sender {
    isFiltered = NO;
    [self.mainTable reloadData];
}
@end
