//
//  GameViewController.h
//  Shoot
//
//  Created by Thomas Mac on 14/06/2016.
//  Copyright © 2016 Thomas Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelTableViewController.h"

@interface GameViewController : UIViewController <UIAlertViewDelegate>

@property(nonatomic) int level;
@property(nonatomic) int difficulte;

@property(nonatomic, weak) LevelTableViewController *levelTableViewController;

- (void) feu;

@end
