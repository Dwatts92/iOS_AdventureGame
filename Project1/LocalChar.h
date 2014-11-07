//
//  LocalChar.h
//  Project1
//
//The main variable I use to hold everything.
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
