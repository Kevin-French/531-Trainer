//
//  SurveyDAO.h
//  531 Trainer
//
//  Created by Kevin French on 1/3/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SurveyDAO;

@protocol SurveyDAODelegate <NSObject>

-(void)submissionSucceeded;
-(void)submissionFailed;

@end



@interface SurveyDAO : NSObject

@property (nonatomic, weak) id <SurveyDAODelegate> delegate;

-(void)submitSurveyResponses:(NSArray *)responses;

@end