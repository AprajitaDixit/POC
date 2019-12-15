//
//  FeedViewModel.m
//  POC_Example
//
//  Created by Mini on 14/12/19.
//  Copyright © 2019 aprajitadixit. All rights reserved.
//

#import "FeedViewModel.h"
#define APIUrl @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
#define httpGetFormat @"GET"

@implementation FeedViewModel

-(void)fetchFeedsFromApiwithCompletion:(void (^)(NSArray<FeedModel*>*result, NSString* title, NSError *error))block {
    
    _dataSource = [[FeedDataSource alloc]init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:APIUrl]];
    [request setHTTPMethod: httpGetFormat];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSData * responseData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (responseDict == nil) {
          block(nil, @"", error);
            return;
        }
        NSMutableArray<FeedModel*>* dataModel = [[NSMutableArray<FeedModel*> alloc]init];
        NSString* headerTite = responseDict[@"title"];
        for(NSDictionary *jsonDict in responseDict[@"rows"]) {
            FeedModel* model = [[FeedModel alloc]init];
            model.title = [jsonDict valueForKey:@"title"];
            model.subTitle = [jsonDict valueForKey:@"description"];
            model.imageUrl = [jsonDict valueForKey:@"imageHref"];
            [dataModel addObject:model];
        }
        block(dataModel, headerTite, nil);
    }] resume];
}

@end
