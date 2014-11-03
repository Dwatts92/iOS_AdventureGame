//
//  Character.m
//  Project1
//
//  Created by Dylan on 11/3/14.
//  Copyright (c) 2014 Dylan. All rights reserved.
//

#import "Character.h"

@implementation Character


-(void)encodeWithCoder:(NSCoder *)aCoder    //encodes attributes
{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.charType forKey:@"charType"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder    //initalization
{
    self = [super init];
    
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.charType = [aDecoder decodeObjectForKey:@"charType"];
    
    return self;
}

-(NSString *)description    //gives a string with its data
{
    
    return [NSString stringWithFormat:@"Name:%@ Type:%@",self.name, self.charType];
    
}


@end
