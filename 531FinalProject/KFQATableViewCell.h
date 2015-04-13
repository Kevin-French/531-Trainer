//
//  KFQATableViewCell.h
//  531 Trainer
//
//  Created by Kevin French on 1/2/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFQATableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;

@end
