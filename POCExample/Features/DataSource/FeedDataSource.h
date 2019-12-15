//
//  FeedDataSource.h
//  POC_Example
//
//  Created by Mini on 14/12/19.
//  Copyright © 2019 aprajitadixit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedTableViewCell.h"

@interface FeedDataSource : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray<FeedModel *>* feedArray;

@end
