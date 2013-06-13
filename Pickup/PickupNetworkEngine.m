//
//  PickupNetworkEngine.m
//  Pickup
//
//  Created by ALAIN KHUON on 15/05/13.
//  Copyright (c) 2013 ALAIN KHUON. All rights reserved.
//

#import "PickupNetworkEngine.h"

@implementation PickupNetworkEngine

+ (MKNetworkEngine *)instance
{
    static MKNetworkEngine * _instance = nil;
    @synchronized(self)
    {
        _instance = [[MKNetworkEngine alloc] init];
    }
    return _instance;
}

@end
