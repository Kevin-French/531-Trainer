//
//  LiftSettingsCollectionViewCell.h
//  531 Trainer
//
//  Created by Kevin French on 3/25/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiftSettingsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *liftLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *incrementAmountLabel;

@end
