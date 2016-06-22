//
//  LevelTableViewController.h
//  Shoot
//
//  Created by Thomas Mac on 12/06/2016.
//  Copyright © 2016 Thomas Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellWithThreeButtons.h"

@interface LevelTableViewController : UITableViewController

- (void) sauvegarder:(int)level difficulte:(int)difficulte;

- (void) setButtonsHidden:(TableViewCellWithThreeButtons*)cell withIndice:(int)indice;

- (void) setButtonsImage:(TableViewCellWithThreeButtons*)cell withIndice:(int)indice;

- (void) launchGame:(TableViewCellWithThreeButtons*)cell;

@end
