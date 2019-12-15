//
//  Utility.m
//  POCExample
//
//  Created by Mini on 15/12/19.
//  Copyright © 2019 Mini. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(UIButton*)addRetryButton:(UIView*)view {
    UIButton* retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [retryButton setHidden:false];
    [retryButton setTitle:@"Retry" forState:UIControlStateNormal];
    [retryButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [retryButton setBackgroundColor:[UIColor lightGrayColor]];
    [retryButton.layer setCornerRadius:3.0];
    retryButton.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:retryButton];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[retryButton(150)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(retryButton)]];
     [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[retryButton(50)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(retryButton)]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:retryButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:retryButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    return retryButton;
}

+(UIActivityIndicatorView*)showActivityIndicator:(UIView*)view {
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    indicator.color = [UIColor blackColor];
    indicator.hidesWhenStopped = YES;
    indicator.center = view.center;
    [view addSubview:indicator];
    return indicator;
}

+(void)showAlert:(NSString*)title message:(NSString*)errorMessage controller:(UIViewController*)ctrl completion:(void (^)(UIAlertAction * action))block {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                   message:errorMessage
                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        block(action);
    }];
    [alert addAction:defaultAction];
    [ctrl presentViewController:alert animated:YES completion:nil];
}

@end
