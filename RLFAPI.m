//
//  RLFAPI.m
//  miniTeambox
//
//  Created by Raimon Lapuente on 20/05/13.
//  Copyright (c) 2013 RaimonLapuente. All rights reserved.
//

#import "RLFAPI.h"

@implementation RLFAPI

NSString const *token = @"WOtjiwVzIa4dsUzPnhSS";
NSString const *account = @"https://teambox.com/api/1/account?access_token=";
NSString const *taskList = @"https://teambox.com/api/1/task_lists?access_token=";
NSString const *tasks = @"https://teambox.com/api/1/tasks?access_token=";

- (NSDictionary *) baseRequest: (NSString *) url
{
    NSURL *newUrl = [[NSURL alloc] initWithString:url];
    NSError *error;
    NSURLRequest *request = [NSURLRequest requestWithURL:newUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return result;
}

- (NSDictionary *) getAccount
{
    NSString *request = [NSString stringWithFormat:@"%@%@",account,token];
    NSDictionary *result = [self baseRequest:request];
    return result;
}

- (NSDictionary *) getTaskCats
{
    NSString *request = [NSString stringWithFormat:@"%@%@",taskList,token];
    NSDictionary *result = [self baseRequest:request];
    return result;
}

- (NSDictionary *) getTasks
{
    NSString *request = [NSString stringWithFormat:@"%@%@",tasks,token];
    NSDictionary *result = [self baseRequest:request];
    return result;
}

@end
