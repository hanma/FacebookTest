//
//  FBRequest+Block.h
//  FbAutoCheckin
//
//  Created by Han Ma on 19/03/12.
//  Copyright (c) 2012 hasnotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"


typedef void (^CompletionHandler)(id result);
typedef void (^ErrorHandler)(NSError *error);

@interface FBRequest(block)

@property (nonatomic,copy) CompletionHandler completionHandler;
@property (nonatomic,copy) ErrorHandler errorHandler;

@end
