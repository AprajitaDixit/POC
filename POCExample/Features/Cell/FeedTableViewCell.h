//
//  FeedTableViewCell.h
//  POC_Example
//
//  Created by Mini on 14/12/19.
//  Copyright © 2019 aprajitadixit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedModel.h"

@interface FeedTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* descriptionLabel;
@property (strong, nonatomic) UIImageView* feedImageView;

-(void)setUpDataWithModelObject:(FeedModel*)object;

@end
