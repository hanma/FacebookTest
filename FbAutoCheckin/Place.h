//
//  Place.h
//  FbAutoCheckin
//
//  Created by Han Ma on 21/03/12.
//  Copyright (c) 2012 hasnotes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject
@property (nonatomic,copy) NSString* PlaceID;
@property (nonatomic,copy) NSString* PlaceName;
@property (nonatomic,copy) NSString* CheckedMessage;
@property (nonatomic,assign) float Latitude;
@property (nonatomic,assign) float Longtitude;
@end
