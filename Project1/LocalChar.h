//
//  LocalChar.h
//  Project1
//
//  Local char is the variable that holds all the player's character attributes.
//

#import <Foundation/Foundation.h>

@interface LocalChar : NSObject

@property NSString* charName;       //name of character
@property NSString* charType;       //class, mage, archer, or warrior
@property int gridProgress;         //progress made in the game. Starts at 0, is 21 at the end of the game.             Buttons in the MainScreen add to this number and progress the game.
@property int health;               //health of your character
@property int strength;             //strength value
@property int agility;              //agility value
@property int intellect;            //intellect value
@property int itemCount;            //monitors progress of items retrived in game, is basically a seed. There are 4 items but 5 different seeds, check out items.m to see how this works.

-(instancetype)initWithName:(NSString*)charName initWithType:(NSString*)charType;   //initializes with name and character type

@end
