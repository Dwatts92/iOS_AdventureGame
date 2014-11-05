//
//  LocalChar.m
//  Project1
//
//  Created by Dylan on 11/3/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "LocalChar.h"

@implementation LocalChar

-(instancetype)initWithName:(NSString*)charName initWithType:(NSString*)charType  //initializes BalanceModel object for use in other classes
{
    self = [super init];
    if(self)
    {
        self.charName = charName;
        self.charType= charType;
    }
    return self;
}

@end
