//
//  LocalChar.h
//  Project1
//
//  Created by Dylan on 11/3/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalChar : NSObject

@property NSString* charName;
@property NSString* charType;
@property int gridProgress;
@property int health;
@property int strength;
@property int agility;
@property int intellect;
@property int itemCount;

-(instancetype)initWithName:(NSString*)charName initWithType:(NSString*)charType;

@end
