//
//  SurveyDAO.m
//  531 Trainer
//
//  Created by Kevin French on 1/3/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import "SurveyDAO.h"
#import "AFNetworking.h"

static NSString * const BaseURLString = @"http://web.engr.illinois.edu/~kbfrenc2/531Trainer/WebService";

@implementation SurveyDAO

-(NSArray *)getParameterKeys {
    return [[NSArray alloc] initWithObjects:@"q1", @"q2", @"q3", @"q4", @"q5", @"q6", @"q7", @"q8", @"q9", @"q10", nil];
}

-(void)submitSurveyResponses:(NSArray *)responses {

    NSDictionary * parameters = [[NSDictionary alloc] initWithObjects:responses forKeys:[self getParameterKeys]];
    
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    
    // 2
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:@"webService.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        int rowsEffected = [[responseObject objectAtIndex:0] intValue];
    
        if (rowsEffected == 1) {
            [self.delegate submissionSucceeded];
        } else {
            [self.delegate submissionFailed];
        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", [error description]);
        [self.delegate submissionFailed];
    }];
}

@end