//
//  LocalChar.m
//  Project1
//
//The main variable I use to hold everything.
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
