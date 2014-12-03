//
//  LocalChar.m
//  Project1
//
//  Local char is the variable that holds all the player's character attributes.

#import "LocalChar.h"

@implementation LocalChar

-(instancetype)initWithName:(NSString*)charName initWithType:(NSString*)charType  //initializes LocalChar object for use in other classes
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
