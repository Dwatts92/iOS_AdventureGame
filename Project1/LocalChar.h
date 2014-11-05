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

-(instancetype)initWithName:(NSString*)charName initWithType:(NSString*)charType     ;

@end
