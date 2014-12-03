//
//  Character.m
//  Project1
//
// Gets files from local character attributes, stores them in file for continuing game.
//

#import "Character.h"

@implementation Character


-(void)encodeWithCoder:(NSCoder *)aCoder    //encodes attributes
{
    
    [aCoder encodeObject:self.charName forKey:@"charName"];
    [aCoder encodeObject:self.charType forKey:@"charType"];
    [aCoder encodeInt:self.gridProgress forKey:@"gridProgress"];
    [aCoder encodeInt:self.health forKey:@"health"];
    [aCoder encodeInt:self.strength forKey:@"strength"];
    [aCoder encodeInt:self.agility forKey:@"agility"];
    [aCoder encodeInt:self.intellect forKey:@"intellect"];
    [aCoder encodeInt:self.itemCount
               forKey:@"itemCount"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder    //initalization
{
    self = [super init];
    
    self.charName = [aDecoder decodeObjectForKey:@"charName"];
    self.charType = [aDecoder decodeObjectForKey:@"charType"];
    self.gridProgress = [aDecoder decodeIntForKey:@"gridProgress"];
    self.health = [aDecoder decodeIntForKey:@"health"];
    self.strength = [aDecoder decodeIntForKey:@"strength"];
    self.agility = [aDecoder decodeIntForKey:@"agility"];
    self.intellect = [aDecoder decodeIntForKey:@"intellect"];
    self.itemCount = [aDecoder decodeIntForKey:@"itemCount"];
    
    return self;
}

-(NSString *)description    //gives a string with its data
{
    
    return [NSString stringWithFormat:@"Name:%@ Type:%@ Grid Progress:%d/21 Health: %d Strength: %d Agility: %d Intellect: %d Item Progress: %d",self.charName, self.charType,self.gridProgress,self.health, self.strength,self.agility,self.intellect,self.itemCount];
    
}


@end
