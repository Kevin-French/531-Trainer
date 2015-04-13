//
//  KFSurveyViewController.m
//  531 Trainer
//
//  Created by Kevin French on 1/2/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import "KFSurveyViewController.h"
#import "KFQATableViewCell.h"
#import "SurveyDAO.h"

@interface KFSurveyViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextViewDelegate, SurveyDAODelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KFSurveyViewController {
    NSArray * _questions;
    NSMutableArray * _answers;
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:textView.tag inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    

    if ([textView.text isEqualToString:@"Enter response here"]) {
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Enter response here";
    }
    
    [_answers setObject:textView.text atIndexedSubscript:textView.tag];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row < [_questions count]) {
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initQuestionsArray];
    [self initAnswersArray];
    self.view.backgroundColor = [UIColor darkGrayColor];
}

-(void)initQuestionsArray {
    NSString * q1 = @"What is your favorite part of the app?";
    NSString * q2 = @"What is your least favorite part of the app?";
    NSString * q3 = @"What feature(s) do you use the most?";
    NSString * q4 = @"What feature(s) do you use the least?";
    NSString * q5 = @"What feature(s) would you like added?";
    NSString * q6 = @"What feature(s) would you like removed?";
    NSString * q7 = @"Would you rather the next version be free with ads or $1 with no ads?";
    NSString * q8 = @"How often do you use the app?";
    NSString * q9 = @"Any other comments?";
    NSString * q10 = @"Enter your email address below if you would like to be notified when version 2.0 is released?";
    
    _questions = [[NSArray alloc] initWithObjects:q1,q2,q3,q4,q5,q6,q7,q8,q9,q10, nil];
}

-(void)initAnswersArray {
    _answers = [[NSMutableArray alloc] initWithObjects:@"Enter response here", @"Enter response here", @"Enter response here", @"Enter response here", @"Enter response here", @"Enter response here", @"Enter response here", @"Enter response here", @"Enter response here", @"Enter response here", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)submitPressed:(id)sender {
    SurveyDAO * dao = [[SurveyDAO alloc] init];
    dao.delegate = self;
    [dao submitSurveyResponses:[_answers copy]];
}

-(void)submissionSucceeded {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Thank You" message:@"Thank you for completing the survey, your feedback is much appreciated."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)submissionFailed {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Submission Failed" message:@"Your survery submission failed, please try again."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


-(void)addKeyboardUtilityBarToTextView:(UITextView *)textView {
    
    UIToolbar* keyboardButtonsView = [[UIToolbar alloc] init];
    [keyboardButtonsView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    
    [keyboardButtonsView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    textView.inputAccessoryView = keyboardButtonsView;
}

-(void)doneClicked:(id)sender {
    [self.view endEditing:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ([_questions count] + 1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QACell"];
    KFQATableViewCell * QACell = (KFQATableViewCell *) cell;
    QACell.answerTextView.tag = indexPath.row;
    
    if (indexPath.row == [_questions count]) {
        QACell.questionLabel.text = @"";
        QACell.answerTextView.text = @"";
        [QACell.answerTextView setEditable:NO];
        cell.backgroundColor = [UIColor clearColor];
    } else {
        QACell.questionLabel.text = [_questions objectAtIndex:indexPath.row];
        QACell.answerTextView.text = [_answers objectAtIndex:indexPath.row];
        QACell.answerTextView.editable = YES;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    QACell.answerTextView.delegate = self;
    [self addKeyboardUtilityBarToTextView:QACell.answerTextView];

    return cell;
}

@end
