//
//  RLFAPI.h
//  miniTeambox
//
//  Created by Raimon Lapuente on 20/05/13.
//  Copyright (c) 2013 RaimonLapuente. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLFAPI : NSObject

- (NSDictionary *) getAccount;
- (NSDictionary *) getTaskCats;
- (NSDictionary *) getTasks;

@end
