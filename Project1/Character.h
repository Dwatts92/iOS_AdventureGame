//
//  Character.h
//  Project1
//
// Character class for persistence
//

#import <Foundation/Foundation.h>

@interface Character : NSObject <NSCoding>

//This is basically the same as LocalChar class. I create an object of LocalChar once a New Game starts, and then whenever I save or load on this game, this class gets all the values from the LocalChar class, and it gets saved or loaded to storage.

@property NSString* charName;
@property NSString* charType;
@property int gridProgress;
@property int health;
@property int strength;
@property int agility;
@property int intellect;
@property int itemCount;


@end
