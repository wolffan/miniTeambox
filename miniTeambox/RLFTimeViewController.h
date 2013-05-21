//
//  RLFTimeViewController.h
//  miniTeambox
//
//  Created by Raimon Lapuente on 21/05/13.
//  Copyright (c) 2013 RaimonLapuente. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLFTimeViewController : UIViewController

- (IBAction)performSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *from;
@property (weak, nonatomic) IBOutlet UIDatePicker *to;

@end
