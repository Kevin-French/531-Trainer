//
//  CycleCollectionViewCell.h
//  531 Trainer
//
//  Created by Kevin French on 3/25/15.
//  Copyright (c) 2015 Kevin French. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@end
