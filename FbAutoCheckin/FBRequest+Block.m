//
//  FBRequest+Block.m
//  FbAutoCheckin
//
//  Created by Han Ma on 19/03/12.
//  Copyright (c) 2012 hasnotes. All rights reserved.
//

#import "FBRequest+Block.h"
#import <objc/runtime.h>


NSString * const completionHandlerKey = @"completionHandlerKey";
NSString * const errorHandlerKey = @"completionHandlerKey";

@implementation FBRequest(block)

-(void)setCompletionHandler:(CompletionHandler)completionHandler
{
    objc_setAssociatedObject(self,&completionHandlerKey,completionHandler,OBJC_ASSOCIATION_COPY); 
}

-(CompletionHandler)completionHandler
{
    return objc_getAssociatedObject(self, &completionHandlerKey);
}

-(void)setErrorHandler:(ErrorHandler)errorHandler
{
    objc_setAssociatedObject(self,&errorHandlerKey,errorHandler,OBJC_ASSOCIATION_COPY); 
}

-(ErrorHandler)errorHandler
{
    return objc_getAssociatedObject(self, &errorHandlerKey);
}

@end
