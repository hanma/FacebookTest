//
//  FacebookManager.m
//  FbAutoCheckin
//
//  Created by Han Ma on 19/03/12.
//  Copyright (c) 2012 hasnotes. All rights reserved.
//

#import "FacebookManager.h"


@interface FacebookManager()


@end

FacebookManager *facebookManageer;

@implementation FacebookManager

@synthesize facebook = _facebook,loggedin = _loggedin;

+(FacebookManager*) defaultManager
{
    if (!facebookManageer)
        facebookManageer = [[FacebookManager alloc]init];
    
    return facebookManageer;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.loggedin = NO;
        
        if (!self.facebook)
        {
            self.facebook = [[Facebook alloc]initWithAppId:@"154853137937862" andDelegate:self];
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([defaults objectForKey:@"FBAccessTokenKey"] 
                && [defaults objectForKey:@"FBExpirationDateKey"]) 
            {
                self.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
                self.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
            }
            
            if (![self.facebook isSessionValid])
            {
                
                NSArray *permissions = [[NSArray alloc] initWithObjects:
                                        @"user_checkins",
                                        nil];
                
                [self.facebook authorize:permissions];
                
            }
            else 
            {
                self.loggedin = YES;
            }
            
        }
        
    }
    
    return self;
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
    
}

- (void)fbDidExtendToken:(NSString*)accessToken
expiresAt:(NSDate*)expiresAt
{
    
}

- (void)fbDidLogout
{
    
}


- (void)fbSessionInvalidated
{
    
}

- (void)fbDidLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setValue:self.facebook.accessToken forKey:@"FBAccessTokenKey"];
    [defaults setValue:self.facebook.expirationDate forKey:@"FBExpirationDateKey"];
    
    [defaults synchronize];
    self.loggedin = YES;
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    
    if (error && request.errorHandler)
    {
        request.errorHandler(error);
        NSLog(error.userInfo);
    }
};

- (void)request:(FBRequest *)request didLoad:(id)result
{
    if (result && request.completionHandler)
    {
        request.completionHandler([result valueForKey:@"data"]);
    }
}

-(void)loadChekinsWithCompletionHandler:(CompletionHandler)completionHandler 
                        andErrorHandler:(ErrorHandler)errorHandler
{
    
    FBRequest* request = [self.facebook requestWithGraphPath:@"me/checkins" andDelegate:self];
    request.completionHandler = completionHandler;
    request.errorHandler = errorHandler;
}




@end
