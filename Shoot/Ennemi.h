//
//  Ennemi.h
//  Shoot
//
//  Created by Thomas Mac on 14/06/2016.
//  Copyright © 2016 Thomas Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameViewController.h"

@interface Ennemi : NSObject

- (void) initInstanceInViewController:(GameViewController*)gameViewController rapidite:(float)rapidite;

- (void) stopTimer;

- (BOOL) isHidden;

- (void) setFrameWithLimiteHaut:(int)limiteHaut limiteBas:(int)limiteBas;

- (void) setHidden;

- (float) getX;

- (float) getY;

- (float) getWidth;

- (float) getHeigth;

@end
