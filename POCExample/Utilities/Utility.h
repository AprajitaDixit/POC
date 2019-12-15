//
//  Utility.h
//  POCExample
//
//  Created by Mini on 15/12/19.
//  Copyright © 2019 Mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

+(UIButton*)addRetryButton:(UIView*)view;
+(UIActivityIndicatorView*)showActivityIndicator:(UIView*)view;
+(void)showAlert:(NSString*)title message:(NSString*)errorMessage controller:(UIViewController*)ctrl completion:(void (^)(UIAlertAction * action))block;

@end
