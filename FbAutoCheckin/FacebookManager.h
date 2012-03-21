//
//  FacebookManager.h
//  FbAutoCheckin
//
//  Created by Han Ma on 19/03/12.
//  Copyright (c) 2012 hasnotes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"
#import "FBRequest+Block.h"

@interface FacebookManager : NSObject<FBSessionDelegate,FBRequestDelegate>

@property (nonatomic,strong) Facebook* facebook;
@property(nonatomic,assign) BOOL loggedin;


+(FacebookManager*) defaultManager;

-(void)loadChekinsWithCompletionHandler:(CompletionHandler)completionHandler 
                        andErrorHandler:(ErrorHandler)errorHandler;

@end
