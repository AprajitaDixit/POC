//
//  FeedModel.h
//  POC_Example
//
//  Created by Mini on 14/12/19.
//  Copyright © 2019 aprajitadixit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedModel : NSObject

@property (strong, readwrite, nonatomic) NSString* title;
@property (strong, readwrite, nonatomic) NSString* subTitle;
@property (strong, readwrite, nonatomic) NSString* imageUrl;

@end
