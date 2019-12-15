//
//  FeedViewModel.h
//  POC_Example
//
//  Created by Mini on 14/12/19.
//  Copyright © 2019 aprajitadixit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedDataSource.h"

@interface FeedViewModel : NSObject

@property (strong, nonatomic) FeedDataSource* dataSource;

-(void)fetchFeedsFromApiwithCompletion:(void (^)(NSArray<FeedModel*>*result, NSString* title, NSError *error))block;

@end
