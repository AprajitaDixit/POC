//
//  FeedTableViewCell.m
//  POC_Example
//
//  Created by Mini on 14/12/19.
//  Copyright © 2019 aprajitadixit. All rights reserved.
//

#import "FeedTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
#define IS_IPAD_DEVICE  ([(NSString *)[UIDevice currentDevice].model hasPrefix:@"iPad"])

@implementation FeedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpTitleLabel];
        [self setUpDescriptionLabel];
        [self setUpImage];
        [self addAutoLayoutToCellContent];
    }
    return self;
}

-(void)setUpTitleLabel {
    self.titleLabel = [UILabel new];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:IS_IPAD_DEVICE?28:18]];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
}

-(void)setUpDescriptionLabel {
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.descriptionLabel.numberOfLines = 0;
    [self.descriptionLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:IS_IPAD_DEVICE? 24:14]];
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.descriptionLabel];
}

-(void)setUpImage {
    self.feedImageView = [UIImageView new];
    self.feedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.feedImageView];
}

-(void)addAutoLayoutToCellContent {
    [self.feedImageView.superview addConstraint:[NSLayoutConstraint
    constraintWithItem:self.feedImageView.superview attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.feedImageView attribute:NSLayoutAttributeCenterY  multiplier:1.0 constant:0.0]];
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_feedImageView(50)]-[_titleLabel]-|" options:0 metrics:nil views: NSDictionaryOfVariableBindings(_feedImageView, _titleLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_feedImageView(50)]" options:0 metrics:nil views: NSDictionaryOfVariableBindings(_feedImageView)]];
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_feedImageView(50)]-[_descriptionLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_feedImageView, _descriptionLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-6-[_descriptionLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel, _descriptionLabel)]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}

-(void)setUpDataWithModelObject:(FeedModel*)object {

    if (object.title && ![object.title isEqual: [NSNull null]]){
        self.titleLabel.text = object.title;
    } else {
        self.titleLabel.text = @"";
    }
    if (object.subTitle && ![object.subTitle isEqual: [NSNull null]]) {
        self.descriptionLabel.text = object.subTitle;
    } else {
        self.descriptionLabel.text = @"";
    }
    if (object.imageUrl && ![object.imageUrl isEqual: [NSNull null]]) {
        [self.feedImageView sd_setImageWithURL: [NSURL URLWithString: object.imageUrl]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    } else {
        self.feedImageView.image = nil;
    }
}

@end
