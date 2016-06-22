//
//  TableViewCellWithThreeButtons.h
//  Shoot
//
//  Created by Thomas Mac on 12/06/2016.
//  Copyright © 2016 Thomas Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellWithThreeButtons : UITableViewCell

@property(nonatomic, strong) UITableViewController *levelTableViewController;

@property(nonatomic) int indice;

@property(nonatomic) int level;
@property(nonatomic) int difficulte;

- (void) setButtonsHidden:(BOOL)hidden;

- (void) setFirstButtonImage;
- (void) setSecondButtonImage;
- (void) setThirdButtonImage;

@end
