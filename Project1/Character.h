//
//  Character.h
//  Project1
//
// Character class for persistence
//

#import <Foundation/Foundation.h>

@interface Character : NSObject <NSCoding>


@property NSString* charName;
@property NSString* charType;
@property int gridProgress;
@property int health;
@property int strength;
@property int agility;
@property int intellect;
@property int itemCount;


@end
